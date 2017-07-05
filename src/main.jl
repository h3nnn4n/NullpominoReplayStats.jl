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
    totalLines = 0
    gmt = now()

    rplay_ok = false

    open(name) do f
        for line in readlines(f)
            if contains(line, "0.ruleopt.strRuleName=STANDARD-FAST-B")
                rplay_ok = true
            elseif contains(line, "timestamp.gmt")
                nss = replace(replace(line, r"timestamp.gmt=", ""), r"\n", "")
                df = "yyyy-mm-dd-HH-MM-SS"
                #=println(df)=#
                #=println(nss)=#
                #=println(DateTime(nss, df))=#
                df = DateTime(nss, df)
                #=println(Dates.format(df, "yyyy-mm-dd HH:MM:SS"))=#
                gmt = df
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
                nss = replace(replace(line, r"0.statistics.time=", ""), r"\n", "")
                time = parse(Int32, nss)
                #=println("time ", time)=#
            elseif contains(line, "statistics.totalPieceActiveTime=")
                nss = replace(replace(line, r"0.statistics.totalPieceActiveTime=", ""), r"\n", "")
                totalPieceActiveTime = parse(Int32, nss)
                #=println("totalPieceActiveTime ", totalPieceActiveTime)=#
            elseif contains(line, "statistics.gamerate=")
                nss = replace(replace(line, r"0.statistics.gamerate=", ""), r"\n", "")
                gamerate = parse(Float64, nss)
                #=println("gamerate ", gamerate)=#
            elseif contains(line, "statistics.totalPieceLocked=")
                nss = replace(replace(line, r"0.statistics.totalPieceLocked=", ""), r"\n", "")
                totalPieceLocked = parse(Int32, nss)
                #=println("pieces ", totalPieceLocked)=#
            elseif contains(line, "statistics.lpm=")
                nss = replace(replace(line, r"0.statistics.lpm=", ""), r"\n", "")
                lpm = parse(Float64, nss)
                #=println("lpm ", lpm)=#
            elseif contains(line, "statistics.lps=")
                nss = replace(replace(line, r"0.statistics.lps=", ""), r"\n", "")
                lps = parse(Float64, nss)
                #=println("lps ", lps)=#
            elseif contains(line, "statistics.pps=")
                nss = replace(replace(line, r"0.statistics.pps=", ""), r"\n", "")
                pps = parse(Float64, nss)
                #=println("pps ", pps)=#
            elseif contains(line, "statistics.ppm=")
                nss = replace(replace(line, r"0.statistics.ppm=", ""), r"\n", "")
                ppm = parse(Float64, nss)
                #=println("ppm ", ppm)=#
            elseif contains(line, "result.totallines=")
                nss = replace(line, r"result.totallines=", "")
                totalLines = parse(Int32, nss)
                #=println("pps ", totalLines)=#
            end
        end
    end

    return game_data(rplay_ok, pps, ppm, gamerate, lps, lpm, time, totalPieceActiveTime, totalPieceLocked, totalLines, gmt)
end

function main()
    name = ARGS[1]

    base_pwd = pwd()
    cd(name)

    for file in readdir(name)
        if contains(file, ".rep")
            data = parse_rep(file)

            if data.ok && data.totalLines == 40
                #=println(data)=#
                @printf("%s %f %f %f\n", Dates.format(data.gmt, "yyyy-mm-dd-HH:MM:SS"), data.totalPieceActiveTime / 60.0, data.pps, data.lps)
            end
        end
    end

    cd(base_pwd)
end

main()
