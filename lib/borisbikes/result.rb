module BorisBikes
  class Result

    attr_reader :id
    attr_reader :name
    attr_reader :lat
    attr_reader :long
    attr_reader :available
    attr_reader :empty
    attr_reader :total
    attr_reader :installed
    attr_reader :locked
    attr_reader :temporary

    def initialize(result)

      if result.class != Hash
        raise ArgumentError, "expected Hash for result parameter"
      end

      if result["updatedOn"]
        @updated = result["updatedOn"]
      else
        raise ArgumentError, "result hash doesn't include updatedOn"
      end

      if result["dockStation"].nil?
        raise ArgumentError, "result hash doesn't include dockStation"
      end

      ds = result["dockStation"]

      @id = ds["@ID"]
      @name = ds["name"]
      @lat = ds["latitude"]
      @long = ds["longitude"]
      @available = ds["bikesAvailable"].to_i
      @empty = ds["emptySlots"].to_i
      @total = @available + @empty
      @installed = (ds["installed"] == "true")
      @locked = (ds["locked"] == "true")
      @temporary = (ds["temporary"] == "true")

    end

  end
end
