module WikidotAPI

  # Wikidot API client class to handle XML-RPC api as described at
  # http://www.wikidot.com/doc:api
  class Client
    def initialize app, key, opts={}
      @app, @key = app, key
      @host = opts[:host] || "www.wikidot.com"
      @proto = opts[:proto] || "https"
      @port = opts[:port] || false
    end

    def call method, *args
      try_count = 0
      begin
        server.call method, *args
      rescue IOError => e
        @server = nil
        try_count += 1
        raise if try_count == 3
        retry
      end
    end

    def proxy(prefix=nil, *args)
      XMLRPC::Client::Proxy.new(self, prefix, args, :call)
    end

    def method_missing method
      proxy method.to_s
    end

    def server
      @server ||= XMLRPC::Client.new2 endpoint_uri
    end

    def endpoint_uri
      "#{@proto}://#{@app}:#{@key}@#{@host}#{@port ? ':' + @port.to_s : ''}/xml-rpc-api.php"
    end

    private :server, :endpoint_uri
  end
end