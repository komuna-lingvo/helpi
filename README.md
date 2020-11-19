<h1>
<p align="center">
<a href="https://github.com/komuna-lingvo/helpi">Helpi</a>
<br>
<strong style="display: block">S.O.S Alerts</strong>
</p>
</h1>

## :bulb: About

One day, while eating breakfast I was listening to the radio, they were talking about an app. 

It took out my curiosity,
I wanted to know WHY [this app](https://play.google.com/store/apps/details?id=com.botondeauxilio.android) was so popular.

I read the comments, see the preview images and finally downloaded it.

My first impression was: Do I really have pay for this? 
Also, I didn't understand the decisions taken for the solution, the design was basic too.

I thought I can redesign it and make it FREE.

## :pushpin: Why that name?

Is easy to remember, and I recently consider [Esperanto](https://es.wikipedia.org/wiki/Esperanto) to name my apps.

## :eyes: Design

- Big picture [here](https://www.figma.com/file/vkKnSh9OnaEOhiXhk6Qj0f/Helpi?node-id=0%3A1).
- Prototype navigation [here](https://www.figma.com/proto/vkKnSh9OnaEOhiXhk6Qj0f/Helpi?node-id=1%3A5&scaling=scale-down).

<strong>BUT</strong>, at the time of developing, the ``Helpi SMS`` functionality it is not in the ROADMAP yet.

This is because I was planning to use [AWS Amplify](https://docs.amplify.aws/start/getting-started/setup/q/integration/flutter), 
but it is still on DEVELOPER PREVIEW, and some functionalities [are still lacking](https://github.com/aws-amplify/amplify-flutter#to-be-implemented).

## :dart: Proposed Solution

The solution is very simple. I will try to explain based on what I saw from the app.

- This is an opinion based on my experience. Before asking for a permission you should always detail the reason.

Might be redundant, but helps the user to understand WHY you need the functionality.
  
- I don't need you to create an account to use the app. Unless some specific cases.

For this app I believe I don't need it. (NOT YET)

- There are just 2 buttons: Health and Safety. This is an SOS alert app, so it makes sense.

So, why not create your own buttons, with different situations.

- This one doesn't make sense to me. Why choose contacts from a list of people I don't even know?

I prefer choose contacts from my phone. People I know and trust.

- Finally, I believe (this is my POV) I shouldn't charge for a solution if I can help people. 

## :muscle: TODO

- [ ] AWS Amplify Flutter
- [ ] i18n
- [ ] Integration tests
