require 'uri'
require 'net/http'
require 'open3'
require 'json'

paste_cmd = ARGV[1]
copy_cmd = ARGV[2]
server_loc = ARGV[0]

puts "Get buffer: " + copy_cmd
puts "Put buffer: " + paste_cmd 

set_uri = URI.parse("http://#{server_loc}:4567/paste")
get_uri = URI.parse("http://#{server_loc}:4567/paste")
lastpaste = `#{copy_cmd}`

while true

    # Check for changes
    paste = `#{copy_cmd}`
    if paste != lastpaste
        puts "New paste buffer detected: posting: " + paste
        http_post = Net::HTTP.new(set_uri.host, set_uri.port)
        req = Net::HTTP::Post.new(set_uri.request_uri)
        req.body = paste
        http_post.request(req)
        lastpaste = paste
    end

    # Get current paste from server
    response = Net::HTTP.get_response(get_uri)
    serv_paste = JSON.parse(response.body)["result"]
    if serv_paste != lastpaste
        puts "New paste buffer from server: setting: " + serv_paste
        stdin, stdout, stderr = Open3.popen3(paste_cmd)
        stdin.print(serv_paste)
        stdin.close()
        lastpaste = serv_paste
    end

    sleep(1)
end
