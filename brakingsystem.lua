local component = require("component")
local computer = require("computer")
local event = require("event")
--local detector = component.ir_augment_detector
--local controler = component.ir_augment_control
local info,consist = nil,nil
local loco_speed = 0


function brakingsystem()

    while true do
        print("wait train...")
        event_name, net_address, augment_type, stock_uuid = event.pull("ir_train_overhead")
        print("come train")
        
        print(augment_type)

        if augment_type == "DETECTOR" then
            print("getpos()="..component.proxy(net_address).getPos() )
            info = component.proxy(net_address).info()
            consist = component.proxy(net_address).consist()
            
            if consist == nil then
                goto continue
            end
            
            loco_speed = consist.speed_km

        elseif augment_type == "LOCO_CONTROL" then

            for net_address in component.list("ir_augment_control") do
                if loco_speed > 60 then
                    component.proxy(net_address).setThrottle(-1.0)
                    component.proxy(net_address).setBrake(1)
                elseif loco_speed > 40 then
                    component.proxy(net_address).setThrottle(0.0)
                    component.proxy(net_address).setBrake(0.5)
                elseif loco_speed > 25 then
                    component.proxy(net_address).setThrottle(0.2)
                    component.proxy(net_address).setBrake(0.25)
                else
                    component.proxy(net_address).setThrottle(0.3)
                    component.proxy(net_address).setBrake(0)
                end
            end
        else
            print("--other type augment!!!!--")
        end
        
        ::continue:: --continue文の代わり
    end

end

brakingsystem()
