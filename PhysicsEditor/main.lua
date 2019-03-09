local inspect = require("lib.inspect")

local Editor = require("src.Editor")


function love.load()
    
    editor = Editor()

    editor.resources:CreateWorld("MyWorld",0,9.81)
    print(tostring(editor.resources:HasWorld("MyWorld") == true))
    editor.resources:DeleteWorld("MyWorld")
    print(tostring(editor.resources:HasWorld("MyWorld") == false))

    editor.resources:CreateBody("MyBody")
    print(tostring(editor.resources:HasBody("MyBody") == true))
    editor.resources:DeleteBody("MyBody")
    print(tostring(editor.resources:HasBody("MyBody") == false))
    
    editor.resources:CreateFixture("MyFixture")
    print(tostring(editor.resources:HasFixture("MyFixture") == true))
    editor.resources:DeleteFixture("MyFixture")
    print(tostring(editor.resources:HasFixture("MyFixture") == false))
    
    editor.resources:CreateShape("MyShape")
    print(tostring(editor.resources:HasShape("MyShape") == true))
    editor.resources:DeleteShape("MyShape")
    print(tostring(editor.resources:HasShape("MyShape") == false))

end

function love.update(dt)
end

function love.draw()
end