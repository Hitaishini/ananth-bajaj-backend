class Calculator

def self.limit_and_offset(params)
	if params[:limit] && params[:offset]
		limit = (params[:limit] || 50000).to_i
		offset = (params[:offset] || 1).to_i
		offset = (offset == 1 ? offset : ((offset - 1) * limit) + 1) if params[:offset]
  	offset = offset
	else
		limit = 50000
		offset = 0
	end	 
  return limit, offset
end	

end