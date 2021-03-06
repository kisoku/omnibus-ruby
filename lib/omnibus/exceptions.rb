module Omnibus

  class InvalidS3Configuration < RuntimeError
    def initialize(s3_bucket, s3_access_key, s3_secret_key)
      @s3_bucket, @s3_access_key, @s3_secret_key = s3_bucket, s3_access_key, s3_secret_key
    end

    def to_s
      """
      One or more required S3 configuration values is missing.

      Your effective configuration was the following:

          s3_bucket     => #{@s3_bucket.inspect}
          s3_access_key => #{@s3_access_key.inspect}
          s3_secret_key => #{@s3_secret_key.inspect}

      If you truly do want S3 caching, you should add values similar
      to the following in your Omnibus config file:

            s3_bucket      ENV['S3_BUCKET_NAME']
            s3_access_key  ENV['S3_ACCESS_KEY']
            s3_secret_key  ENV['S3_SECRET_KEY']

      Note that you are not required to use environment variables as
      illustrated (and the ones listed have no special significance in
      Omnibus), but it is encouraged to prevent spread of sensitive
      information and inadvertent check-in of same to version control
      systems.

      """
    end
  end

  # Raise this error if a needed Project configuration value has not
  # been set.
  class MissingProjectConfiguration < RuntimeError
    def initialize(parameter_name, sample_value, dsl_file)
      @parameter_name, @sample_value, @dsl_file = parameter_name, sample_value, dsl_file
    end

    def to_s
      """
      You are attempting to build a project, but have not specified
      a value for '#{@parameter_name}' in '#{@dsl_file}'!

      Please add code similar to the following to your project DSL file:

         #{@parameter_name} '#{@sample_value}'

      """
    end
  end

  class MissingSoftwareConfiguration < RuntimeError
    def initialize(parameter_name, sample_value, dsl_file)
      @parameter_name, @sample_value, @dsl_file = parameter_name, sample_value, dsl_file
    end

    def to_s
      """
      You are attempting to build software, but have not specified
      a value for '#{@parameter_name}' in '#{@dsl_file}'!

      Please add code similar to the following to your software DSL file:

         #{@parameter_name} '#{@sample_value}'

      """
    end
  end
end
