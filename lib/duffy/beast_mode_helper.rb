module BeastModeHelper

  # Cache each partial in a collection, then display from cache.
  #
  # IMPORTANT: This only works if you've wrapped your partial in a cache block.
  #            If you don't it will take longer than just calling render()
  #            You also need the Parallel gem installed: https://github.com/grosser/parallel
  #
  # Examples:
  #   beast_mode(@jobs)
  #   beast_mode(partial: 'jobs/job', collection: @jobs)
  #
  def beast_mode(options = {})

    if defined? Parallel

      if options.is_a?(Hash)
        # eg: beast_mode(partial: 'jobs/job', collection: @jobs)

        # Issue ArgumentError if anything is missing
        raise ArgumentError.new("partial: option is required") unless options.has_key?(:partial)
        raise ArgumentError.new("collection: option is required") unless options.has_key?(:collection)

        collection = options[:collection]
        partial = options[:partial]

        # Issue ArgumentError if collection isn't a collection
        raise ArgumentError.new("collection doesn't look like something I can render") unless collection.respond_to?(:each)


        # silently render each partial as quickly as possible.  It's up to you to include a cache block!
        Parallel.each(collection, in_processes: MAX_PROCESSES) do |object|
          render(partial: partial, object: object)
        end
      else
        # eg: beast_mode(@jobs)
        # Generate the Cache fragments for each object in parallel as fast as possible, but don't show them yet
        Parallel.each(options, in_processes: MAX_PROCESSES) do |object|
          render(object)
        end
      end
    else
      warn "  [WARNING] beast_mode is not executing in parallel.  Please add https://github.com/grosser/parallel"
    end

    # Display the cached fragments.
    render(options)
  end
end
