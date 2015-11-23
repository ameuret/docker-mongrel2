BUILD_STAMP = "build_stamp"
DOCKERFILE = "Dockerfile"
IMAGE_TAG = "mitaka.actime.biz:5000/docker-mongrel2:latest"
  
task :default => :build
desc "Build docker image from #{DOCKERFILE}"
task :build => BUILD_STAMP

task :push => :build do
  cmd = "docker push #{IMAGE_TAG}"
  puts "Pushing image: #{cmd}"
  `#{cmd}`
end
  
file BUILD_STAMP => [DOCKERFILE] do
  cmd = "docker build -t #{IMAGE_TAG} ."
  puts "Building Docker image: #{cmd}"
  `#{cmd}`
  touch BUILD_STAMP
end

  
