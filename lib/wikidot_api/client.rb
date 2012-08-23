module WikidotAPI

  # Wikidot API client class to handle XML-RPC api as described at
  # http://www.wikidot.com/doc:api
  class Client
    def initialize app, key, opts={}
      @app, @key = app, key
      @host = opts[:host] || "www.wikidot.com"
      @proto = opts[:proto] || "https"
      @port = opts[:port] || false
      @query_options = opts[:query_options] || false
    end

    def call method, *args
      try_count = 0
      begin
        server.call_async method, *args
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
    
    def query_options_string
      "?" + @query_options.map{|o| "#{CGI.escape(o[0].to_s)}=#{CGI.escape(o[1].to_s)}"}.join("&") if @query_options
    end

    def endpoint_uri
      "#{@proto}://#{@app}:#{@key}@#{@host}#{@port ? ':' + @port.to_s : ''}/xml-rpc-api.php#{query_options_string}"
    end

    private :server, :endpoint_uri, :query_options_string
  end
end