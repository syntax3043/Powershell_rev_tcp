function Speak
{

    Param( 
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $Sentence
    )
    (new-object -com SAPI.SpVoice).speak("$Sentence")
}