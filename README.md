<h1 align='center'> PitchPerfect - Udacity project </h1>

<p>The Pitch Perfect app allows users to record a sound using the device’s microphone. It then allows users to play the recorded sound back with four different sound modulations: Chipmunk, Darth Vader, Super Slow, and Super Fast. </p>
The app has two view controller scenes:
<ul>
<li>Record Sounds View: allows users to record a sound.</li>
<li>Play Sounds View: allows users to play the recorded sound back with effects.</li>
</ul>

The two scenes are described in detail below.

<h5>Record Sounds View</h5>

The record sounds view is the initial view for the app, and consists of a button with a microphone image.
Tapping this microphone button starts an audio recording session. The app use code from AVFoundation to record sounds from the microphone.
Tapping the button disables the record button, displays a “recording” label, and presents a stop button.
When the stop button is clicked, the app completes its recording and then pushes the second scene (described below under “Play Sounds View”) onto the navigation stack.


<h5> Play Sounds View </h5>

The play sounds view has four buttons to play the recorded sound file and a button to stop the playback.
The buttons for playing the recorded sounds have images corresponding to their sound effect:
<ul>
<li> Chipmunk image → High-pitched sound </li>
<li> Darth Vader image →  Low-pitched sound </li>
<li> Snail image → Slow sound </li>
<li> Rabbit image → Fast sound </li>
</ul>
