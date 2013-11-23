require 'uri'
require 'net/http'
require 'open3'

paste_cmd = ARGV[0]
copy_cmd = ARGV[1]

puts "Get buffer: " + copy_cmd
puts "Put buffer: " + paste_cmd 

set_uri = URI.parse('http://localhost:4567/setpaste')
get_uri = URI.parse('http://localhost:4567/getpaste')
lastpaste = `#{copy_cmd}`

http_post = Net::HTTP.new(set_uri.host, set_uri.port)
http_get = Net::HTTP.new(get_uri.host, get_uri.port)

while true

    # Check for changes
    paste = `#{copy_cmd}`
    if paste != lastpaste
        puts "New paste buffer detected: posting: " + paste
        req = Net::HTTP::Post.new(set_uri.request_uri)
        req.body = paste
        http_post.request(req)
        lastpaste = paste
    end

    # Get current paste from server
    response = Net::HTTP.get_response(get_uri)
    serv_paste = response.body
    if serv_paste != lastpaste
        puts "New paste buffer from server: setting: " + serv_paste
        stdin, stdout, stderr = Open3.popen3(paste_cmd)
        stdin.puts(serv_paste)
        stdin.close()
        lastpaste = serv_paste
    end

    sleep(1)
end
