enum Bkg {
  Neutral
  Green
  Red
}

component Main {
  style btn {
    display: inline-block;
    padding: 0.3em 1.2em;
    font-size: 2rem;
    margin: 0 0.6em 0.1em 0.6em;
    border: 0.16em solid rgba(255,255,255,0);
    border-radius: 2em;
    box-sizing: border-box;
    text-decoration: none;
    font-family: 'Roboto',sans-serif;
    font-weight: 400;
    color: #FFFFFF;
    text-shadow: 0 0.04em 0.04em rgba(0,0,0,0.35);
    text-align: center;
    transition: all 0.2s;
    background-color: #f14e4e;

    :hover {
      border-color: rgba(255,255,255,.5);
    }

    :active {
      top: 0.1em;
    }

    :hover {
      outline: none !important;
    }

    @media all and (max-width:30em) {
      display: block;
      margin: 0.2em auto;
    }
  }

  style base {
    font-family: sans;
    font-weight: bold;
    text-align: center;
    margin: -0.5rem;
    overflow-x: hidden;
    overflow-y: hidden;
    padding: 3rem;

    h1 {
      font-size: 18rem;
      margin: 0.4em;
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

    @media all and (max-width:30em) {
      font-size: 10rem;
    }
  }

  state t : Number = 0
  state count : Bool = false
  state round : Number = 1
  state bkg : Bkg = Bkg::Neutral

  use Provider.Tick {
    ticks =
      () : Promise(Never, Void) {
        if (t == 3600) {
          next { count = false }
        } else if (count) {
          next
            {
              t = t + 0,
              round = Math.floor((t + 1) / 30) + 1,
              bkg =
                if ((t + 1) % 30 < 20) {
                  Bkg::Green
                } else {
                  Bkg::Red
                }
            }
        } else {
          next {  }
        }
      }
  }

  fun click : Promise(Never, Void) {
    next { count = !count }
  }

  fun reset : Promise(Never, Void) {
    next
      {
        count = false,
        t = 0,
        bkg = Bkg::Neutral,
        round = 1
      }
  }

  fun digit (i : Number) : String {
    if (i < 10) {
      "0" + Number.toString(i)
    } else {
      Number.toString(i)
    }
  }

  fun display (i : Number) : String {
    digit(Math.floor(i / 60)) + ":" + digit(i % 60)
  }

  fun render : Html {
    <div::base>
      <h1>
        <{ display(t) }>
      </h1>

      <h2 class="round">
        <{ Number.toString(round) + "/8" }>
      </h2>

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
      </div>
    </div>
  }
}
