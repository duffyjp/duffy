module Duffy

  # I like to have a git log in the admin section of my websites.  I use these in my capistrano tasks to
  # generate what I need and upload along with the deployment.

  class Git
    class << self

      # Produce tab separated listing of current git log.
      # Useful for displaying a development history page.
      def log
        `git log --pretty=format:"%ad%x09%an%x09%s" --date=short`
      end

      # I tend use the commit count / 1000.0 as a version for my applications.
      # You wouldn't want to do that if you're building a gem used by others.
      def count
        `git rev-list HEAD --count`
      end

    end
  end
end
