enum Bkg {
  Neutral
  Green
  Red
}

component Main {
  state sec : Number = -1
  state count : Bool = false
  state round : Number = 1
  state totalRounds : Number = 8
  state bkg : Bkg = Bkg::Neutral
  state streak : Number = 0
  state roundHighScore : Number = 2

get totalRoundNumber : Number {
  if (streak == 0) {
    1
  } else if (streak <= 7) {
    2
  } else if (streak <= 14) {
    3
  }  else if (streak <= 21) {
    4
  } else if (streak <= 28) {
    5
  } else if (streak <= 35) {
    6
  }  else if (streak <= 42) {
    7
  }  else {
    8
  }
}
  fun render : Html {
    <div::base>
      <link 
        rel="stylesheet" 
        href="https://cdn.jsdelivr.net/gh/tonsky/FiraCode@2/distr/fira_code.css"
      />
      <audio id="begin">
        <source src="sound/begin.wav" type="audio/wav"/>
      </audio>
      <audio id="rest">
        <source src="sound/rest.wav" type="audio/wav"/>
      </audio>

      <div style="text-align: right;">
      <div::streak style="display: inline;">
        <{ "🔥" + Number.toString(streak)  }>
      </div>
      <a::streak style="display: inline;">
      if (false) {
        "Login"
      }
      </a>
      </div>

      <h1>
        <{ display(sec) }>
      </h1>

      if (false) {
      <h2 class="round">
        <{ Number.toString(round) + "/" + Number.toString(roundHighScore) }>
      </h2>
      } else {
      <h2 class="round">
        <{ Number.toString(round) + "/" + Number.toString(totalRoundNumber) }>
      </h2>
      }


      <div>
        <button::btn onClick={click}>
          if (count) {
            "STOP"
          } else {
            "START"
          }
        </button>

        <button::btn onClick={reset}>
          "RESET"
        </button>

        <button::btn onClick={incStreak}>
          "STREAK+"
        </button>

        <button::btn
          onClick={
            () : Promise(Never, Void) {
              setStreak(0)
            }
          }>

          "CLEAR STREAK"

        </button>
      </div>
      <Info />
    </div>
  }


  fun componentDidMount : Promise(Never, Void) {
    parallel {
      next { streak = s, roundHighScore = r }
    }
  } where {
    s =
      getStreakFromStorage()
    r =
      getRoundHighScore()
  }
  use Provider.Tick {
    ticks =
      () : Promise(Never, Void) {
        if (sec == 3600) {
          next { count = false }
        } else if (count) {
          try {
            if ( (sec + 1) % 30 == 0) {
              play("begin")
            } else if ( (sec + 1) % 30 == 20) {
              play("rest")
            } else {
              true
            }
            next
              {
                sec = sec + 1,
                round = Math.floor((sec + 1) / 30) + 1,
                bkg =
                  if ((sec + 1) % 30 < 20) {
                    Bkg::Green
                  } else {
                    Bkg::Red
                  }
              }
            }
        } else {
          next {  }
        }
      }
  }
  fun play(s : String) : Bool {
    `
    (() => {
     var x = document.getElementById(#{s});
     x.play();
     return true;
    })()
    `
  }
  fun setRoundHighScore (n : Number) : Promise(Never, Void) {
    parallel {
      `window.localStorage.setItem('roundMax', #{n})`
      next { roundHighScore = n }
    }
  }
  fun getRoundHighScore : Number {
    `
    (() => {
      var roundHighScore = parseInt(localStorage.getItem('roundMax'));
      if (isNaN(roundHighScore)) {
        window.localStorage.setItem('roundMax', 2);
        roundHighScore = 2;
      }
      return roundHighScore;
    })()
    `
  }
  fun getStreakFromStorage : Number {
    `
    (() => {
      var streak = parseInt(localStorage.getItem('streak'));
      console.log(streak);
      if (isNaN(streak)) {
        window.localStorage.setItem('streak', 0);
        streak = 0;
      }
      return streak;
    })()
    `
  }

  fun setStreak (n : Number) : Promise(Never, Void) {
    parallel {
      `window.localStorage.setItem('streak', #{n})`
      next { streak = n }
    }
  }

  fun incStreak : Promise(Never, Void) {
    setStreak(s)
  } where {
    s =
      streak + 1
  }


  fun reset : Promise(Never, Void) {
    next
      {
        count = false,
        sec = 0,
        bkg = Bkg::Neutral,
        round = 1
      }
  }

  fun click : Promise(Never, Void) {
    next { count = !count }
  }

  fun display (i : Number) : String {
    if (i < 0) {
      "00:00"
    } else {
    digit(Math.floor(i / 60)) + ":" + digit(i % 60)
    }
  }

  fun digit (i : Number) : String {
    if (i < 10) {
      "0" + Number.toString(i)
    } else {
      Number.toString(i)
    }
  }

  get totalTime : Number {
    60 * totalRounds - 10
  }

  style btn {
    display: inline-block;
    padding: 0.3em 1.2em;
    font-size: 2rem;
    margin: 0 0.6em 0.1em 0.6em;
    border: 0.16em solid rgba(255,255,255,0);
    border-radius: 2em;
    box-sizing: border-box;
    text-decoration: none;
    font-family: 'Fira Code',sans-serif;
    font-weight: 400;
    color: #FFFFFF;
    text-shadow: 0 0.04em 0.04em rgba(0,0,0,0.35);
    text-align: center;
    transition: all 0.2s;
    background-color: #f14e4e;

    @media (max-width: 960px) {
      font-size: 1.5rem;
    }

    &:hover {
      outline: none !important;
    }

    &:active {
      top: 0.1em;
    }
  }

  style base {
    font-family: 'Fira Code', serif;
    font-weight: bold;
    margin: -0.5rem;
    overflow-x: hidden;
    overflow-y: hidden;
    padding-top: 3rem;
    text-align: center;

    h1 {
      font-size: 18rem;
      margin: 0 0;
    }

    h2 {
      font-size: 10rem;
      margin: 0.2rem 0.2rem 7rem 0.2rem;
    }

    case (bkg) {
      Bkg::Neutral =>
      Bkg::Red => background: #FF0000;
      Bkg::Green => background: #0ff07f;
    }

    @media all and (max-width: 960px) {
      h1 {
        font-size: 30vw;
        text-align: center;
      }

      h2 {
        font-size: 4rem;
        margin: 0.2rem 0.2rem 7rem 0.2rem;
      }
    }

    @media all and (max-width: 920px) {
      h1 {
        font-size: 20vw;
        text-align: center;
      }

      h2 {
        font-size: 4rem;
        margin: 0.2rem 0.2rem 7rem 0.2rem;
      }
    }
  }

  style streak {
    text-align: right;
    font-size: 3rem;
    margin-top: 0rem;
    margin-bottom: 0rem;
    padding: 0 1rem;

    @media (max-width: 800px) {
      font-size: 2.5rem;
    }
  }

}

