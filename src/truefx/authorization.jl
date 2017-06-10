TrueFX = Val{:TrueFX}

TrueFX_username = "TrueFX_username"
TrueFX_password = "TrueFX_password"
TrueFX_qualifier = "eurates"
TrueFX_format = "csv" # or "html"
TrueFX_currencypairs = "EUR/USD,GBP/USD,CAN/USD,AUD/USD"
ENV["TrueFX_sessionid"] = ""

try
   TrueFX_username = ENV[TrueFX_username]
   TrueFX_password = ENV[TrueFX_password]
catch  KeyError
    throw(ErrorException(
        """You must register a username and password with TrueFX and put them in the environment.\n\t
           Use your .juliarc.jl file:\n\t\t
           ENV["TrueFX_username"] = "<your username>"\n\t\t
           ENV["TrueFX_password"] = "<your password>"\n
        """))
end

const truefx_connect_url = "http://webrates.truefx.com/rates/connect.html"
const truefx_authentication_url = string(truefx_connect_url,"?u=",TrueFX_username,"&p=",TrueFX_password)
truefx_authorization_url = string(truefx_authentication_url,"&q=",TrueFX_qualifier,"&f=",TrueFX_format)

# e.g. "EUR/USD" or "EUR/USD,EUR/GBP"
function truefx_currency_pairs(currencypairs::V) where V<:AbstractVector{S} where S<:String
   return join(V, ",")
end
truefx_currency_pairs(currencypairs::String) = currencypairs

function truefx_currency_pairs!(currencypairs::String)
    global truefx_authorization_url
    truefx_authorization_url = split(truefx_authorization_url,"&c=")[1]
    truefx_authorization_url = string(truefx_authorization_url,"&c=",currencypairs)
    return nothing
end   

truefx_authorization_url = truefx_currency_pairs!(truefx_currency_pairs)
   
function sessionid(::Type{TrueFX}; force::Bool=false)
    global truefx_authorization_url
    if force || length(ENV["TrueFX_sessionid"]) == 0
        response = Requests.get(truefx_authorization_url)
        newsessionid = chomp(readstring(response))
        verify_authorization(TrueFX, newsessionid, response.status)
        ENV["TrueFX_sessionid"] = newsessionid
    end
    return ENV["TrueFX_sessionid"]
end
   
function verify_authorization(::Type{TrueFX}, obtained::String, status::Int)
    if status != 200
        throw(ErrorException("TrueFX did not process the authorization: status error."))      
    end  
    if obtained === "not authorized"
        throw(ErrorException("TrueFX did not authorize the username and password given"))
    end
end
  

