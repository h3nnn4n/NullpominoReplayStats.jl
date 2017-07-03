include("types.jl")

function parse_rep(name)
    pps = 0.0
    ppm = 0.0
    gamerate = 0.0
    time = 0
    totalPieceActiveTime = 0
    totalPieceLocked = 0
    lps = 0.0
    lpm = 0.0

    rplay_ok = false

    open(name) do f

        for line in readlines(f)
            if contains(line, "0.ruleopt.strRuleName=STANDARD-FAST-B")
                rplay_ok = true
            elseif contains(line, "timestamp.time")
                #=nss = replace(line, r"timestamp.time=", "")=#
                #=ns  = chop(replace(nss, r"\\:", "."))=#


                #=ns_split = split(ns, ".")=#

                #=xh_, xm_, xs_ = ns_split=#

                #=xh = parse(Int32, xh_)=#
                #=xm = parse(Int32, xm_)=#
                #=xs = parse(Int32, xs_)=#

                #=println("time ", xh, xm, xs)=#
            elseif contains(line, "statistics.time=")
                nss = chop(replace(line, r"0.statistics.time=", ""))
                time = parse(Int32, nss)
                #=println("time ", time)=#
            elseif contains(line, "statistics.totalPieceActiveTime=")
                nss = chop(replace(line, r"0.statistics.totalPieceActiveTime=", ""))
                totalPieceActiveTime = parse(Int32, nss)
                #=println("totalPieceActiveTime ", totalPieceActiveTime)=#
            elseif contains(line, "statistics.gamerate=")
                nss = chop(replace(line, r"0.statistics.gamerate=", ""))
                gamerate = parse(Float64, nss)
                #=println("gamerate ", gamerate)=#
            elseif contains(line, "statistics.totalPieceLocked=")
                nss = chop(replace(line, r"0.statistics.totalPieceLocked=", ""))
                totalPieceLocked = parse(Int32, nss)
                #=println("pieces ", totalPieceLocked)=#
            elseif contains(line, "statistics.lpm=")
                nss = chop(replace(line, r"0.statistics.lpm=", ""))
                lpm = parse(Float64, nss)
                #=println("lpm ", lpm)=#
            elseif contains(line, "statistics.lps=")
                nss = chop(replace(line, r"0.statistics.lps=", ""))
                lps = parse(Float64, nss)
                #=println("lps ", lps)=#
            elseif contains(line, "statistics.pps=")
                nss = chop(replace(line, r"0.statistics.pps=", ""))
                pps = parse(Float64, nss)
                #=println("pps ", pps)=#
            elseif contains(line, "statistics.ppm=")
                nss = chop(replace(line, r"0.statistics.ppm=", ""))
                ppm = parse(Float64, nss)
                #=println("ppm ", ppm)=#
            end
        end
    end

    return game_data(rplay_ok, pps, ppm, gamerate, lps, lpm, time, totalPieceActiveTime, totalPieceLocked)
end

function main(name)
    println("Opening ", name)
    parse_rep(name)
end

