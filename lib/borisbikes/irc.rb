require 'borisbikes/bikestats'

module BorisBikes

  class IRC

    include Cinch::Plugin

    match "bikes", :method => :bikes

    def initialize(*args)
      super
      @api = BorisBikes::Bikestats.new
      @stands = config["stands"]
    end

    def bikes(m)
      if @stands.nil?
        m.reply "Interesting bike stands configuration missing"
        m.reply "Add an array of stand IDs to cinchize.yml"
        bot.plugins.unregister_plugin(self)
        return
      end
      results = []
      @stands.each do |id|
        results << @api.get(id)
      end
      renders = render(results)
      renders.each do |say|
        m.reply say
      end
    end

    private

    def render(results)
      renders = {}
      results.each do |result|
        renders.merge!(render_add(result))
      end
      longest = 0
      renders.keys.each do |name|
        longest = name.length if longest < name.length
      end
      output = []
      renders.each do |name, result|
        output << "%#{longest}s: %s" % [name, result]
      end
      output
    end

    def render_add(result)
      name = result.name.sub(/,.*$/,'').strip
      av = result.available
      empty = result.empty
      rep_av = "|" * av
      rep_empty = "." * empty
      {
        name =>
        "%2d available [%s]" % [
          av,
          rep_av + rep_empty
        ]
      }
    end

  end

end
