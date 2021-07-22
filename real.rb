require 'notify-send' #this is use for sending desktop notifcation

puts "Enter your session time in minute"
session=gets.to_i

puts "Enter your starting time of online break in minute"
start=gets.to_i

puts "Enter the durartion of online break in minute"
dur=gets.to_i

# converting seconds to minute
session_in_min=session*60
start_in_min=start*60
durartion_in_min=dur*60

def curr_time # this function is just for checking our time for debugging purpose
    tm=Time.now 
    # puts " #{tm.hour}:#{tm.min}:#{tm.sec}"
    x=" #{tm.hour}:#{tm.min}:#{tm.sec}"
end
tmp=1 # this variable use to check our session is complete or not

def offline tmp,session_in_min,start_in_min,durartion_in_min 
    ct=curr_time
    if tmp>=session_in_min
        NotifySend.send({summary: "Your session is completed", timeout: 4000})
        puts "Your session completed at #{ct}"
        curr_time
        exit
    end

    puts "offline session activated at #{ct}"
    NotifySend.send({summary: "Offline session started", timeout: 4000})
     system("nmcli radio wifi off")
    sleep start_in_min
    tmp+=start_in_min
    online tmp,session_in_min,start_in_min,durartion_in_min
end

def online tmp,session_in_min,start_in_min,durartion_in_min
      ct=curr_time
     if tmp>=session_in_min
        NotifySend.send({summary: "Your session is completed", timeout: 4000})
        # curr_time
        puts "Your session completed at #{ct}"
        exit
    end
    puts "online session activated at #{ct}"
    NotifySend.send({summary: "Online session started", timeout: 4000})
    system("nmcli radio wifi on")
    sleep durartion_in_min
    tmp+=durartion_in_min
    offline tmp,session_in_min,start_in_min,durartion_in_min
end

puts "Okay! Be ready to do a deep work, hope you will rock this session, best of luck 👍"
puts "Your wifi will be off and it will be activated in every #{start} min and will stay till #{dur} min in total #{session} min deep work session"
puts "Are ready to start [y/n]"
ch=gets.strip
if ch=='y'
    offline tmp,session_in_min,start_in_min,durartion_in_min 
else
    puts "Bye"
    exit
end