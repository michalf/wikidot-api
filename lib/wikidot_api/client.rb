module WikidotAPI

  # Wikidot API client class to handle XML-RPC api as described at
  # http://www.wikidot.com/doc:api
  class Client
    def initialize app, key, opts={}
      @app, @key = app, key
      @domain = opts[:domain] || "www.wikidot.com"
      @proto = opts[:proto] || "https" 
    end

    def call method, *args
      try_count = 0
      begin
        server.call method, *args
      rescue EOFError => e
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
      "#{@proto}://#{@app}:#{@key}@#{@domain}/xml-rpc-api.php"
    end

    private :server, :endpoint_uri
  end
end