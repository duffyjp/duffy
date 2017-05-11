require 'active_support/core_ext/object/blank'

module Duffy
  # I like to have a git log in the admin section of my websites.  I use these in my capistrano tasks to
  # generate what I need and upload along with the deployment.
  # If for some reason you don't have git installed, each method returns nil.
  class Git
    class << self
      # Produce tab separated listing of current git log.
      # Useful for displaying a development history page.
      def log
        `git log --pretty=format:"%ad%x09%an%x09%s" --date=short`.strip.presence
      rescue
        nil
      end

      # I tend use the commit count / 1000.0 as a version for my applications.
      # You wouldn't want to do that if you're building a gem used by others.
      def count
        `git rev-list HEAD --count`.presence.to_i
      rescue
        nil
      end

      # Read the git committer's email.
      # Uses local if present, otherwise global (git default procedure)
      # nil if unset
      def email
        `git config --get user.email`.strip.presence
      rescue
        nil
      end

      # Display the current branch
      def branch
        `git rev-parse --abbrev-ref HEAD`.strip.presence
      rescue
        nil
      end
    end
  end
end
