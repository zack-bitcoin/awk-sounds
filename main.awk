BEGIN{
    TEMPO = "0.2"#seconds per eighth note.
    make_notes()
    s0 = "e1,d#1,"
    s1 = "e1,d#1,e1,b1,d1,c1,a1,a-1,a1,e-1,a,c,e,a1,b1,e-1,g#-1,b1,e1,g#,b1,c1 a-1,c1 e-1,a,e,e1,d#1,e1,d#1,e1,b1,d1,c1,a1 a-1,a1 e-1,a,c,e,a1,b1 e-1,b1 g#-1,b,e,c1,b1,a1 a-1,a1 e-1,,e1,d#1,"
    s2 = "a1 a-1,a1 e-1,a,b1,c1,d1,e1 c-1,e1 g-1,c,g,f1,e1,d1 b-1,d1 g-1,b,f,e1,d1,c1 a-1,c1 e-1,a,d1,c1,b1 e-2,b1 e-1,e,e,e1,e,e1,e1,e2,d#1,e1,d1,e1,d#1,e1,d1,e1,d1"
    s = s0 s1 s1 s2
    play_all(s)
}
function play_all(s,       M, A, i, N, B, j) {
    M = split(s, A, ",")
    for(i=1; i<=M; i++){
        N = split(A[i], B, " ")
        for(j=1; j<=N; j++){
            play(B[j])
        }
        system("sleep " TEMPO)
    }
}
function make_notes(        s, A, M, i){
    s = "a-2,a#-2,b-2,c-2,c#-2,d-2,d#-2,e-2,f-2,f#-2,g-2,g#-2,a-1,a#-1,b-1,c-1,c#-1,d-1,d#-1,e-1,f-1,f#-1,g-1,g#-1,a,a#,b,c,c#,d,d#,e,f,f#,g,g#,a1,a#1,b1,c1,c#1,d1,d#1,e1,f1,f#1,g1,g#1,a2,a#2,b2,c2,c#2,d2,d#2,e2,f2,f#2,g2,g#2,a3,a#3,b3,c3,c#3,d3,d#3,e3,f3,f#3,g3,g#3"
    M = split(s, A, ",")
    for(i=1; i<=M; i++){
        make(note(-25+i), TEMPO, A[i])
    }
}
function note(N,      A, S){
    A = 440
    S = 1.05946309436 #12th root of 2.
    return(A * (S ^ N))
}
function make(tone, duration, file){
    system("rm beep_" file ".wav")
    system("ffmpeg -loglevel quiet -f lavfi -i \"sine=frequency=" tone ":duration=" duration "\" beep_" file ".wav")
}
function play(file){
    print("play " file)
    system("aplay -q beep_" file ".wav &")
}
