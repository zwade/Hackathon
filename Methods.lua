
function mergeTables(old,new)
	for k,v in pairs(new) do
		old[k]=v
	end
	return old
end

