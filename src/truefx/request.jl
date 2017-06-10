TrueFX = Val{:TrueFX}

TrueFX_username = "TrueFX_username"
TrueFX_password = "TrueFX_password"
TrueFX_qualifier = "eurates"
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
const truefx_authorization_url = string(truefx_authentication_url,"&q=",TrueFX_qualifier)

function sessionid(::Type{TrueFX}; force::Bool=false)
    if force || length(ENV["TrueFX_sessionid"]) == 0
        response = Requests.get(truefx_authorization_url)
        got = chomp(readstring(response))
        verify_authorization(TrueFX, got)
        newsessionid = split(got, string(TrueFX_qualifier,":")[2]
        ENV["TrueFX_sessionid"] = newsessionid
    end
    return ENV["TrueFX_sessionid"]
end
   
function verify_authorization(::Type{TrueFX}, obtained::String)
    if got === "not authorized"
        throw(ErrorException("TrueFX did not authorize the username and password given"))
    end
end
  


function request(::Type{TrueFX}, uri::String)
    response = Requests.get(truefx_authqualified_url)
if !response.status == 200
    throw(ErrorException("There was either authorization exce
http://webrates.truefx.com/rates/connect.html?u=jsarnoff&p=truefx4jas&q=eurates
