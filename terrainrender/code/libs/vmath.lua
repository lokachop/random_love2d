function vmul(vec, num)
	if type(num) == "table" then
		return {
			vec[1] * num[1],
			vec[2] * num[2],
			vec[3] * num[3]
			}
	else
		return {
		vec[1] * num,
		vec[2] * num,
		vec[3] * num
		}
	end
end

function vadd(vec, num)
	if type(num) == "table" then
		return {
			vec[1] + num[1],
			vec[2] + num[2],
			vec[3] + num[3]
			}
	else
		return {
		vec[1] + num,
		vec[2] + num,
		vec[3] + num
		}
	end
end


function vrot(vec, ang)
	return {
		vec[1] * math.cos(ang) - vec[2] * math.sin(ang),
		vec[1] * math.sin(ang) + vec[2] * math.cos(ang),
		vec[3]
	}


end