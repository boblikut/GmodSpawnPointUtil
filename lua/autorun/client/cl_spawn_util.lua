local spawn_points = {}
local up = 10

concommand.Add( "sputil_add", function()  
	spawn_points[#spawn_points + 1] = LocalPlayer():GetPos() + Vector(0,0,up)
	print("Spawn point has been added!")
end)

concommand.Add( "sputil_print", function()  
	for k,v in ipairs(spawn_points) do
		print("Vector("..math.floor(v[1])..", "..math.floor(v[2])..", "..math.floor(v[3])..")")
	end
end)

local function menu()
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW()*0.25,ScrH()*0.75)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle("Spawnpoint menu")
	local list = vgui.Create("DListView", frame)
	list:SetPos(0,ScrH()*0.05)
	list:SetSize(ScrW()*0.25,ScrH()*0.5)
	list:AddColumn("Spawnpoints")
	for k,v in ipairs(spawn_points) do
		list:AddLine("Vector("..math.floor(v[1])..", "..math.floor(v[2])..", "..math.floor(v[3])..")")
	end
	list.OnRowRightClick = function(line,id)
		for k,v in ipairs(list:GetLines()) do
			list:RemoveLine(k)
		end
		table.remove(spawn_points, id)
		for k,v in ipairs(spawn_points) do
			list:AddLine("Vector("..math.floor(v[1])..", "..math.floor(v[2])..", "..math.floor(v[3])..")")
		end
	end
	local button = vgui.Create("DButton", frame)
	button:SetSize(ScrW()*0.25,ScrH()*0.1)
	button:SetPos(0,ScrH()*0.65)
	button:SetText("Save spawnpoints")
	button.DoClick = function()
		local txt = {"local spawn_points = {"}
		for k, v in ipairs(spawn_points) do
			txt[k + 1] = "    Vector("..math.floor(v[1])..", "..math.floor(v[2])..", "..math.floor(v[3])..")"..","
		end
		txt[#txt + 1] = "}"
		local str = table.concat(txt,"\n")
		print(str)
		file.Write("spawn_points.txt", str)
		print("File has been saved!")
	end
end

concommand.Add( "sputil_menu", menu)
