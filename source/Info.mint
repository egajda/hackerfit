enum Tab {
  Upper
  Lower
  Abs
  Full
  None
}

store Workout.Store {
  state active : Tab = Tab::Upper

  fun click (val : Tab) : Promise(Never, Void) {
    next { active = val }
  }
}

component TabButton {
  connect Workout.Store exposing { active, click }

  style tab {
    font-size: 1.2rem;
    display: inline;
    border-color: #dbdbdb;
    border-style: solid;
    border-width: 1px;
    margin-bottom: 0;
    position: relative;
    padding: 1rem;
    flex-basis: 100%;
    font-size: 1em;
    font-weight: 600;
    line-height: 1.5;

    if (val == active) {
      color: #FFF;
      background-color: hsl(217, 71%, 53%);
    }
  }

  property val : Tab = Tab::None
  property text : String = "Tab Button"

  fun render : Html {
    <li::tab
      onClick={
        (event : Html.Event) : Promise(Never, Void) {
          click(val)
        }
      }>

      <a>
        <span>
          "#{text}"
        </span>
      </a>

    </li>
  }
}

component Workout {
  connect Workout.Store exposing { active }

  style tabs {
    ul {
      display: flex;
      flex-direction: row;
      color: #4a4a4a;
    }
  }

  style sm {
    font-size: 1rem;
  }

  fun render : Html {
    <div>
      <h3>
        "Choices"
      </h3>

      <div::tabs>
        <ul>
          <TabButton
            text="Upper Body"
            val={Tab::Upper}/>

          <TabButton
            text="Lower Body"
            val={Tab::Lower}/>

          <TabButton
            text="Abs"
            val={Tab::Abs}/>

          <TabButton
            text="Full Body"
            val={Tab::Full}/>
        </ul>

        case (active) {
          Tab::Upper =>
            <div>
              <h4>
                "Pushups"
              </h4>

              <p::sm>
                "Easy: Knee Pushups"
              </p>

              <p::sm>
                "Medium: Pushups"
              </p>

              <p::sm>
                "Hard: Clap Pushups"
              </p>

              <p::sm>
                " Insane: 1-Hand Pushups"
              </p>
            </div>

          Tab::Lower =>
            <div>
              <h4>
                "Squats"
              </h4>

              <p::sm>
                "Easy: Squat"
              </p>

              <p::sm>
                "Medium: Jumping Squat"
              </p>

              <p::sm>
                "Hard: Jumping Squat"
              </p>

              <p::sm>
                "Insane: 1-Leg Squat"
              </p>

              <p::sm>
                " (Always know your limits and don't hurt yourselves.)"
              </p>
            </div>

          Tab::Abs =>
            <div>
              <p>
                "Plank"
              </p>

              <p>
                "1 round Bicycle Kick, 1 round Flutter Kick"
              </p>
            </div>

          Tab::Full =>
            <div>
              <h4>
                "Burpees"
              </h4>

              <p>
                "Nuf said. You are a boss."
              </p>
            </div>

          Tab::None => <div/>
        }

        <h3 style="margin-top: 40rem;">
          "Tons of Benefits in No Time"
        </h3>

        <p>
          "Don't let staying inside keep you down.  "
        </p>

        <p>
          "
          It is easy to waste hours at home doing very little but even less
          than 10 minutes a day of focused activity can have astounding 
          effects on your health, body and mind.
          "
        </p>
      </div>
    </div>
  }
}

component Info {
  style info {
    padding: 0 30rem;

    h3 {
      font-size: 3rem;
      padding-top: 5rem;
    }

    p {
      font-size: 1.5rem;
      text-align: left;
      font-weight: 400;
      margin: 3rem 0;
    }

    @media (max-width: 1800px) {
      font-size: 1.2rem;
      padding: 0 7rem;
    }
  }

  fun render : Html {
    <div::info>
      <Workout/>

      <h3>
        "The Secret"
      </h3>

      <p>
        "Consistently doing something effective."
      </p>

      <p>
        "Thats it."
      </p>

      <p>
        "
          There are a million fitness plans, a million optimal ways to workout, a million things we need to get done before we go to the gym.
          "
      </p>

      <p>
        "
          Personally, I've probably spent more times reading about the things I should do than doing them.
          "
      </p>

      <p>
        " This website is designed to do one thing. "
      </p>

      <p>
        <strong>
          "Get you moving."
        </strong>
      </p>

      <h3>
        "Why Tabata"
      </h3>

      <p>
        "Don't worry about it."
      </p>

      <p>
        "Kidding."
      </p>

      <p>
        "A lot of the resistance comes from starting. Don't "
      </p>

      <p>
        "You don't have to download anything, you don't have to watch videos,
        you don't need to go anywhere, you can do it with your roommates (6
        feet apart of course;) and if you do it once a day you will have the
        looks and strength of a greek god in just 30 days.
        "
      </p>

      <p>
        "It's easy. It's simple. I can barely get through 2 minutes of it. You have 2 minutes."
      </p>

      <p>
        "Long story short:"
      </p>

      <ul>
        <li>
          <p>
            "Pick an exercise: Pushups."
          </p>
        </li>

        <li>
          <p>
            "Do it for 20 seconds."
          </p>
        </li>

        <li>
          <p>
            "Take a 10 second break."
          </p>
        </li>

        <li>
          <p>
            "See how many rounds you can last."
          </p>
        </li>
      </ul>

      <p>
        "Congrats you completed what I call 1 Tabata."
      </p>

      <p>
        "You can call it a day or do another one."
      </p>

      <h3>
        "Skeptical? Want to read all the research behind it?"
      </h3>

      <p>
        "Do it after your first Tabata today."
      </p>

      <p>
        "Trust me, in the time you spend googling it you could have already finished and if you don't like it, that's 2 minutes of your life spent trying something new. Big whoop."
      </p>

      <h3>
        "Look like a Greek god? That's the best you got?"
      </h3>

      <p>
        "The real reason to do it is because it's fun."
      </p>

      <p>
        "Every second of it will suck, but a week or two in and you will have a sense of pride and excitement that I can't describe."
      </p>

      <p>
        "Besides, being a god isn't about how you look or how strong you are."
      </p>

      <p>
        "It's about being willing to face a challenge even if you don't think you can win."
      </p>

      <p>
        "And while you are facing that challenge, it's about focusing on nothing else but how can you use every little resource at your disposal to over come it."
      </p>

      <p>
        "(Even Hercules, who is known for his strength wouldn't have gotten further than two challenges with it. Be resourceful and unrelenting.)"
      </p>

      <p>
        "So if you won't do it for any other reason, do it because I'm challenging you!"
      </p>

      <h3>
        "Ok, what's the challenge?"
      </h3>

      <p>
        "Now sure short term goals may help you and feel free to use them if they do but:"
      </p>

      <ul>
        <p>
          <li>
            "This isn't a 7 day challenge"
          </li>
        </p>

        <p>
          <li>
            "This isn't a 30 day challenge"
          </li>
        </p>

        <p>
          <li>
            "This isn't an "

            <em>
              "until-corona-is-gone challenge"
            </em>
          </li>
        </p>
      </ul>

      <p>
        "It's a 1 day challenge."
      </p>

      <p>
        <strong>
          "The challenge is to do at least 1 tabata today"
        </strong>
      </p>

      <p>
        "If you can only last 1 round, do 1 round. Do 4, 8, or till you drop, it doesn't matter."
      </p>

      <p>
        "It doesn't matter if its when you wake up or before you go to bed."
      </p>

      <p>
        "It can be everytime someone in the house coughs or sneezes, or before every single Netflix episode you watch."
      </p>

      <p>
        "Do it for the satisfaction of not shying away from something hard or just to see that streak counter go up everyday."
      </p>

      <p>
        "Just freaking do it."
      </p>

      <p>
        "Don't let that little flame in the corner die out."
      </p>
    </div>
  }
}
