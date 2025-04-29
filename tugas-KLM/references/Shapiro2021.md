# Markov Chains for Computer Music Generation

## Metadata

- **Authors:**
  - Ilana Shapiro (Pomona College)
  - Mark Huber (Claremont McKenna College)
- **Journal:** Journal of Humanistic Mathematics
- **Volume:** 11
- **Issue:** 2
- **Pages:** 167-195
- **Year:** 2021 (July 2021)
- **DOI:** 10.5642/jhummath.202102.08
- **ISSN:** 2159-8118
- **Availability:** https://scholarship.claremont.edu/jhm/vol11/iss2/8
- **Keywords:** randomized algorithms, musical dice games, music composition, Markov chains
- **License:** Creative Commons License (©2021 by the authors)

## Abstract

Random generation of music goes back at least to the 1700s with the introduction of Musical Dice Games. More recently, Markov chain models have been used as a way of extracting information from a piece of music and generating new music. We explain this approach and give Python code for using it to first draw out a model of the music and then create new music with that model.

## Introduction

Randomness has long been used in the generation of music. One of the first methods for randomized music composition, called _Musikalisches Würfelspiel_ (Musical Dice Games), arose in the 18th century. These games were based off the observation that in any piece of music, individual notes of music are combined into measures (or bars), each of which has a fixed length. They work by deciding what an entire bar will sound like at once.

The initial musical dice game was created in 1757 by Johann Philipp Kirnberger, who published a method [2] for composing a polonaise in minuet and trio form. This is an example of a musical form called ternary because it consists of three parts. The first and third parts are the same eight bars, called the minuet. The middle part is called the trio. A simple way to represent this structure is to write ABA, where section A is the minuet and section B is the trio. Each section is eight bars long.

So to create such a musical piece, it was necessary to write down the minuet part (section A) and the trio part (section B). Rather than generate one section at a time, in Kirnberger's game the first measures of both section A and B were generated, then the second measures, and so on until all eight measures were complete.

For a particular measure, the procedure for generating the corresponding minuet measure and the trio measure worked as follows. One would roll two fair six-sided dice, and label the results X1 and X2. X1 was then used in a look-up table to determine the content of that measure of the minuet, and X2 was used in a different look-up table to determine the content of that measure of the trio. Figure 1 shows a table from a 1767 edition [3] of Kirnberger's work. “Premiere partie" indicates the minuet, and “seconde partie" indicates the trio.

For instance, if bar 4 of the minuet were under construction, and the first roll were a 4, then based on Kirnberger's encoding, bar 4 of the minuet (section A) would use piece 74. Similarly, if the second roll were a 2, then bar 4 of the trio (i.e., section B) would use piece 39.

_(Figure 1: Table for using die rolls to construct bars of a minuet and trio. Scan from https://imslp.org/wiki/File:PMLP243537-kirnberger_allezeit_fertiger_usw.pdf.)_

Each roll of the dice for each bar of the result determines a different piece. There are sixteen distinct bars in total in sections A and B, and each bar has six possibilities (since one die is rolled per bar); hence, this game can theoretically produce 6^16 = 2.82110991 × 10^12 different musical compositions.

However, these dice games are greatly restricted in that they rely on a composer that has already created the possible bars to be put together. In other words, the player is merely piecing together already composed music in new ways.

That leaves open the following question: how does one randomly create the individual notes that comprise the bars?

One such approach is to model music using Markov chains, which opens doors to computationally composing arbitrarily long and fully-fledged compositions.

### 1.1. Using Markov chains

In the musical dice game, the bar choices were independent. However, this is a bad idea for note generation. If the notes are changing too rapidly, and each note is independent of the preceding note, the result is more likely to be cacophony than music.

A solution comes with the use of Markov chains. A Markov chain is a sequence of random variables X1, X2, X3, . . . such that the distribution of Xt+1 conditioned on X1,..., Xt only depends on Xt, and not on the values of X1, ..., Xt−1. Markov chains were introduced in 1906 by Andrey Markov [5] as a way of understanding which letters follow others in a typical text.

In this paper, Markov chains are used to determine the sequence of notes (both in pitch and duration). The distribution of the type of the next note will only depend on the current note, and not on any of the notes that came before.

The first use of Markov chains to compose music came in 1957, when the ILLIAC I computer was used to compose the _Illiac Suite_ by Hiller and Isaacson [7]. Since then, Markov chains have been a simple tool for automatically generating a new piece of music. The Markov chains employed by Hiller and Isaacson dealt purely with horizontal melody; in this paper, we endeavor to incorporate harmony and rhythm as well.

In the past sixty years since Hiller and Isaacson, Markov chains have become increasingly popular as a means of music generation. Ramanto and Maulidevi (2017) [6] employed Markov chains for procedural content generation of music, in which music is randomly generated in response to a user-inputted mood. Rather than generating music in the style of an existing piece as this paper seeks to, they sought to generate music in the style of a certain mood. Linskens (2014) [4] also employed Markov chains for algorithmic music improvisation, rather than composition. The Markov chains were trained on an existing piece, like they are in this paper, but then the algorithm was given a certain amount of freedom to vary between the notes of a designated chord or even an unspecified pitch lying somewhere in the bounds of a chord in order to achieve the improvisation quality. This paper does not explore improvisation, though this is certainly an interesting avenue.

Others, such as Yanchenko and Mukherjee (2018) [8] have used more complex statistical models such as time series models, which are variations on Hidden Markov Models (HMMs). With the Hidden Markov Model, instead of generating a sequence of states, each state omits an observable, and the states themselves are hidden. The idea here is to use techniques such as dynamic programming to backtrack from the generated observables in order to determine the optimal sequence of hidden states that generated these observables. Kathiresan (2015) [1] also employs HMMs to generate music against a variety of constraints with the goal of making it sound as subjectively “musical” as possible. This paper does not delve into HMMs, as the aim is to experiment with the musical capabilities of simple Markov chains, but this may certainly be an interesting avenue for future exploration.

The rest of the paper is organized as follows. In the next section (§2), we describe the terminology of Markov chains in more detail. The subsequent sections show how to estimate the parameters of the chain (§3-§4), and then finally a new piece of music is built from an existing piece using these estimates (§5). §6 contains the results of our work and §7 concludes this paper.

## Methods

### 2. Theoretical Foundations of Markov Chains

Consider a sequence of random variables X1, X2, X3, . . .. Such a set of random variables {Xi} forms a stochastic process. The index i in Xi is often called the time. For a fixed time i, Xi is called the state of the chain.

A Markov chain is a stochastic process such that for all i, it holds that
[Xi | X1, . . ., Xi−1] ~ [Xi | Xi−1].

Here the ~ symbol means that the left hand side and the right hand side have the same distribution. In words, this says that the distribution of the ith state in the sequence, given the values of all the states that came before, will depend purely on the previous state. The most common type of Markov chain is also time homogeneous, which means that for all i it holds that [Xi | Xi−1] ~ [X2 | X1]. In other words, the random way in which the state evolves does not change as the time changes.

A Markov chain is also called a memoryless process, since the next state depends purely on the current state, and not on the memory of the notes that came before. In order to describe a time homegeneous Markov chain, it is necessary to know what values the random variables Xi can take on, and what the probabilities are for moving to the next state.

#### 2.1. Representing Markov chains

Markov chains can be represented in a variety of ways. One helpful way is to represent them graphically with a directed graph. This is a collection of nodes and edges, in which each edge has a direction from one node to another. Each node represents a state in the Markov chain, and each edge has a probability associated with it that represents the probability the source node will transition to the destination node (the source and destination node can be the same, which means the process remains in the same state). All the probabilities associated with the edges extending from a node must sum to one (if any edges are omitted, it is assumed that they represent a transition with probability zero).

An example of a graphical representation of a simple Markov chain is shown in Figure 2. The states {Sunny, Windy, Rainy} represent weather, and the probabilities of moving between the three states are above the arrows.

_(Figure 2: Markov Chain graph example.)_

An alternate way of encoding the Markov chain is with the transition matrix, where the (a, b)th entry of the matrix is the probability of moving from state a to state b. The transition matrix for the Markov chain from Figure 2 is as follows.

```
      Sunny Windy Rainy
Sunny  0.6   0.3   0.1
Windy  0.7   0     0.3
Rainy  0.5   0.2   0.3
```

Note that all rows in the transition matrix (or equivalently the probabilities on all outgoing edges) must sum to 1.

### 3. Using Markov Chains to Generate Music

Now consider a given piece of music, which we will call the _training data_. This data will be used to estimate the probabilities for our Markov chain. This chain can then be used to generate music in the same style as the original piece.

In order to generate music, we want the nodes in the Markov chain, or the set of states, to represent _sound objects_. These are entities that represent a single note or chord and contain information about its pitch(es), octave(s), and duration. Thus, each node will contain data about the single note name or collection of notes in the chord, using note names A through G; the accidental (sharp, flat, or natural) for each note, represented by #, b, or no symbol, respectively; the octave for each note, represented by an integer from 0-8; and the duration of the sound object, denoted by a whole note, half note, quarter note, or some shorter value.

One additional special case will be accounted for: the rest, where no sound is played. A rest will be indicated by R. Rests also have a duration.

The set of states will be determined by parsing the piece of music. This process will be discussed shortly, in §4.

We can define our transition matrix by determining the probability for each pair of sound objects s1 and s2, i.e., the chance of moving from s1 to s2 in the chain. In addition, we would also like to define an initial probability vector _I_. This vector gives us the probability that for each state si, the initial state in the chain X1 will be equal to si.

For example, consider the Markov chain represented graphically in Figure 3 that consists of only three sound objects. Note that J represents a quarter note, and ♪ represents an eighth note.

_(Figure 3: Musical Markov Chain example using graphical representation.)_

The set of states in the example is S = {(C#4, E4, A4)J, F4♪, RJ}. The first state is a chord that consists of three notes — C#, E4, and A4 — and lasts for a duration of one quarter note. The second state is a single note F4♪ — with a duration of one eighth note, and the final state is a rest with a duration of one quarter note.

The transition matrix M representation of this chain is shown in Figure 4.

_(Figure 4: Musical Markov Chain example using a transition matrix.)_

```
State             (C#4, E4, A4)J  F4♪     RJ
(C#4, E4, A4)J    0.1176          0.6234  0.2590
F4♪               0.5123          0.0000  0.4877
RJ                0.9995          0.0000  0.0005
```

In order to generate a new piece of music, it is necessary to choose a sound object to start with in our generation. We could simply pick the first sound object in the training data, or we could create an _initial probability vector_ that tells us the probability that each sound object is encountered. We will choose to do the latter and determine our initial probability vector by finding how many total sound objects there are in the piece (including repetitions) and the number of times each individual sound object appears.

To see how this works, suppose that in the training data, (C#4, E4, A4)J appears twice, F4♪ appears three times, and RJ appears once. Then the resulting initial probability vector I is shown in Figure 5.

_(Figure 5: Musical Markov Chain Example Initial Probability Vector)_

```
(C#4, E4, A4)J    F4♪     RJ
0.3333          0.5000  0.1667
```

We now have the tools to generate music from the Markov chain in the same style as the training data.

### 4. Parsing the Training Data

Now we move from theory to practice: using a computer, how can we find the probabilities for our Markov chain, and then simulate a musical score using this chain? The Python language will be used for this exploration.

[Throughout this section, please refer to the file `parse_musicxml.py` in Appendix A.1 for the full Python code. Alternatively, the code as well as the examples are available at the following link: https://github.com/ilanashapiro/Markov-Model-Music-Generation]

The training data (the input musical piece) is given in a symbolic form called MusicXML. It is a file format that encodes musical notation based on extensible markup language (hence the xml ending of MusicXML).

We will use Python's ElementTree library to parse the MusicXML file and the NumPy library to build and manipulate matrices in a class called `Parser`. This class will be used later in the runner file `generate.py` to parse the input MusicXML files. `Parser`'s constructor initializes some important information, such as filename, transition matrix, initial probability vector, and states (the sound objects we will obtain from the input piece).

We initially obtain the data that allows us to build our transition matrix. All sound objects (whether they are chords or individual notes) are extracted sequentially from the MusicXML file and stored in an ordered dictionary alongside the number of times each one appears in the piece. A sound object is uniquely identified by its note(s), accidental, octave, and duration. At this time, we also simultaneously save each sound object in an ordered list (the set of states) in the order it appears. Note that this ordered list, as it represents a set, does not contain repetitions. This process ensures that the sound object dictionary and the list of states contain the same data in the same order, which will allow us to successfully create our transition matrix.

From the dictionary, the transition matrix is created using NumPy. If the length of the list of states (i.e. the number of sound objects) is n, then the transition matrix has dimensions n x n. Both the row and column order correspond to the order of the state dictionary and the list of states. The transition matrix is built as follows:

1.  Using NumPy, the matrix is initialized to the known dimensions n×n. Next, the matrix is built row by row.
2.  Each entry i, j in the matrix is initialized to represent the number of times the ith sound object transitions to the jth sound object in the list of states. At this point, the matrix is symmetric. [Correction: The text says symmetric, but this seems incorrect based on the definition. It should represent counts of transitions *from* i *to* j.]
3.  Once all n² entries have been initialized, NumPy is used to divide all the elements in each row by the row sum.
4.  Finally, for each row, each entry is replaced with the sum of all the previous entries using NumPy's `cumsum` function. This means that the first element in each row will retain the value from the previous step, and all subsequent values will be sequentially greater. Note that because of what we did in the previous step, by applying `cumsum` we ensure that the final value in each row is now 1.

Imagine the ith row representing a line, and each i, j entry representing a segment on that line. The i,j entry that corresponds to the longest line segment is the entry corresponding to some sound object (i.e. state) j that sound object i has the highest probability of transitioning to. This process to transform the data into the line analogy is also known as inverse transform sampling.

The initial probability vector is built in a similar way. This vector has dimensions 1 × n, since we simply want to know the probability that each of n sound objects is chosen at random. We therefore build the initial probability vector as follows:

1.  Using NumPy, a matrix is initialized to the known size of 1 × n (i.e. one row of length n).
2.  The ith entry in the matrix (i.e. the initial probability vector) is initialized to represent the number of times the ith note in the list of states appears in the piece.
3.  Once all n entries have been initialized, NumPy is used to divide all the elements in each row by the row sum.
4.  Finally, NumPy's `cumsum` function is used to replace each entry in the single row of this matrix with the sum of all the previous entries. This means that the first element will retain the value from the previous step, and all subsequent values will be sequentially greater. Note that because of what we did in the previous step, by applying `cumsum` we ensure that the final (i.e. nth) value is now 1.

The line segment analogy applies here exactly the same way as before.

A final thing to note is that the last note in the piece is assigned a transition to a quarter rest, and a transition is then added from the quarter rest to the first note in the piece. This ensures that the Markov model contains no _absorbing states_, or states that once entered, cannot be exited.

### 5. Generating New Music

[Throughout this section, please refer to the file `generate.py` in Appendix A.2.]

Now that we have a working parser that initializes all the elements we need for our Markov chain, we are ready to generate new music in the style of the training data.

We now create a file called `generate.py` and import our parser file (`parse_musicxml.py`). We can instantiate the `Parser` class to create `Parser` objects (i.e., create Markov chains) for however many songs we want, so long as we have the corresponding MusicXML files. In the code attached here, four parsers are created in a list. This allows us to loop through the Parser objects in the list and generate music for the Markov chain that each represents.

In order to generate music from a Markov chain, we start by using NumPy to generate a random number from 0 to 1 inclusive. This is known as a standard uniform random variable. Now consider the initial probability vector. To use our generated standard uniform to draw from this vector, think of the generated random number as being a point on the line segment that is the result of inverse transform sampling having been applied to this vector. This can be visualized in Figure 6.

_(Figure 6: Inverse Transform Sampling example: the blue dot is a uniform draw from 0 to 1, the value of 0.3443 indicates that the draw is F4♪ since that is the next label to the right of the dot.)_

We will choose the next highest state (i.e., sound object) compared to the randomly chosen point we generated. In this example, our randomly generated point would give us the sound object F4♪. [Correction: The text says C3J, but the figure example shows F4♪ corresponding to 0.3443]. This allows us to choose the initial state of the Markov model.

We then generate a sequence of states (i.e., our generated music) from the model starting at this initial state. We follow the same method as above for choosing the next state to transition to, except we now use the transition matrix instead of the initial probability vector. The length of the sequence is determined by the user's input. In the code in the Appendix, the length chosen is 100 notes.

After generating the sequence of sound objects, the sequence is written out to a MIDI file, which is then loaded into the symbolic music software MuseScore for viewing and playing.

## Results

### 6. Results of the Music Generation

The generated music in this paper results from Markov chains trained on excerpts from Shapiro's composition _Cantabile_ for flute and piano. In order to obtain these excerpts, the flute and piano parts were separated, and a short passage was taken from each in order to demonstrate a monophonic example (i.e., the solo flute part), and an example with harmony/chords (i.e., the piano part). The results of the music generated from these parts using their respective Markov chains are as follows:

Figure 7 below contains the original flute part (that is, the training data), and Figure 8 on the next page contains the generated flute part.

_(Figure 7: Original flute part [excerpt from Cantabile by Ilana Shapiro])_
_(Musical Score Snippet)_

_(Figure 8: Generated flute part)_
_(Musical Score Snippet)_

Notice that the generated flute part does not have the same number of measures as the original flute part. When running the program, the user must specify how many measures the generated part will be. This number does not have to match that of the training data, since the training data is only used to create the Markov chain. Once this is complete, arbitrarily long pieces can be generated from the chain.

The generated flute part in Figure 8 contains marked similarities to the original. The rhythm in measure 1 of the generated part is quite similar to the rhythm in measure 4 of the original, and the harmony throughout centers around the key of A major, just like the original, even though the key signature indicates D minor. Additionally, notice the behavior of the C in measures 3-4: it is sometimes flat and sometimes sharp, a behavior picked up from measures 6-7 of the original score. Some notes, such as the first two eighth notes of measure 6 in the generated score, are a direct quote (in this case, of measure 1) from the original. The last beat of measure 2 in the generated score also appears to be an incomplete F# minor scale inspired by measure 4 of the original.

Figure 9 below contains the original piano part (i.e., the training data for piano) and Figure 10 on the next page contains the generated piano part. They also do not have the same number of measures, as was specified by the user before running the program.

_(Figure 9: Original Piano Part [excerpt from Cantabile by Ilana Shapiro])_
_(Musical Score Snippet)_

_(Figure 10: Generated Piano Part)_
_(Musical Score Snippet)_

(Note that because of the way the MIDI file was generated, the generated piano part gets compressed into a single staff. This is not a result of the Markov chain, it is simply due to the MIDI formatting).

The generated piano part in Figure 10 demonstrates melodic, harmonic, and rhythmic qualities from the training piece. The parallel octaves from the original score are frequent throughout the generated part, and harmonic structures (like the augmented C chord (C-E-G#) in the final measure and the A major scale in measure 9) have made their way through as well.

In addition, notice the rhythmic similarity of the scores, particularly the common patterns of sixteenth notes tied over into the next beat and the pattern of four sixteenths, one eighth and two sixteenths, and two eighths that appears in both measure 3 of the original and measure 1 of the generated score.

## Discussion / Conclusion

### 7. Conclusions

Using a simple Markov chain, music can be successfully generated in the style of the training piece. Rhythm, octave, pitch, and accidentals are accounted for. However, there are limitations to the current setup as well as many other avenues to be explored. Currently, the parser does not handle pieces with multiple voices within a single part, or a piece with multiple instruments considered simultaneously, due to difficulty parsing the data from the current musicXML format. In addition, dynamics are not taken into account. Other statistical models, such as the Hidden Markov Model (HMM) mentioned earlier in the paper, may provide interesting avenues of exploration. Using HMMs and dynamic programming, we could, for instance, generate observable notes/chords, and use dynamic programming to uncover the optimal sequence of rhythms, or perhaps dynamics (whatever we choose to be the hidden states) based on the observables. It may also be an interesting avenue to explore the power of simple as well as hidden Markov models in creating less tonal music, and even jazz. It is evident that statistical modeling opens a multitude of creative avenues for computer music generation.

## References

[1] Thayabaran Kathiresan, _Automatic Melody Generation_, PhD thesis, KTH Royal Institute of Technology School of Electrical Engineering, June 2015.
[2] Johann Philipp Kirnberger, _Der allezeit fertige Polonaisen- und Menuettencomponist_, Werner Icking, 1757.
[3] Johann Philipp Kirnberger, _Der allezeit fertige Polonaisen- und Menuettencomponist_, George Ludewig Winter, 1767.
[4] Erlijn J Linskens, _Music Improvisation using Markov Chains_, PhD thesis, Maastricht University, June 2014.
[5] Andrey Andreevich Markov, In Yu. V. Linnik, editor, _Selected Works_, Classics of Science, Academy of Sciences of the USSR, 1951.
[6] Adhika Sigit Ramanto and Nur Ulfa Maulidevi, “Markov chain based procedural music generator with user chosen mood compatibility”, _International Journal of Asia Digital Art & Design_, Volume 21 Issue 1 (March 2017), pages 19-24.
[7] Örjan Sandred, Mikael Laurson, and Mika Kuuskankare, “Revisiting the illiac suite—a rule based approach to stochastic processes", _Sonic Ideas/Ideas Sonicas_, Volume 2 (2009), pages 42-46.
[8] Anna K Yanchenko and Sayan Mukherjee, _Classical Music Composition Using State Space Model_, PhD thesis, Duke University, September 2018.

## Appendix

The following code can also be accessed at https://github.com/ilanashapiro/Markov-Model-Music-Generation

### A.1. parse_MusicXML.py

```python
import xml.etree.ElementTree as ET
import collections
import numpy as np

class Parser:
    def __init__(self, filename):
        self.filename = filename
        self.root = ET.parse(filename).getroot()

        self.initial_transition_dict = collections.OrderedDict()
        self.normalized_initial_probability_vector = None
        self.transition_probability_dict = collections.OrderedDict()
        self.normalized_transition_probability_matrix = None
        self.states = []

        self.smallest_note_value = None # Not used in provided snippet
        self.tempo = None
        self.order_of_sharps = ['F', 'C', 'G', 'D', 'A', 'E', 'B']
        self.key_sig_dict = {'C': '', 'D': '', 'E': '', 'F': '', 'G': '', 'A': '', 'B': ''} # Default C major/A minor
        self.name = None # Piece name
        self.instrument = None

        self.parse()
        self.build_matrices() # Build after parsing

    def parse(self):
        prev_note = None
        sound_object_to_insert = None
        prev_sound_object = None
        in_chord = False
        note = None
        chord = None
        prev_duration = None
        first_sound_object = None

        # Get Tempo (first occurrence)
        try: # Simplified tempo extraction
            for direction in self.root.findall('.//direction[direction-type/metronome]'):
                tempo_mark = direction.find('.//sound')
                if tempo_mark is not None and 'tempo' in tempo_mark.attrib:
                    self.tempo = int(float(tempo_mark.attrib['tempo']))
                    break
        except Exception:
            pass # Keep tempo as None if not found or error

        # Get Instrument (first part)
        try:
            part_list = self.root.find('part-list')
            score_part = part_list.find('score-part')
            part_name_elem = score_part.find('part-name')
            if part_name_elem is not None:
                 self.instrument = part_name_elem.text
                 if self.instrument == 'Piano': # Specific handling for Piano naming convention
                     self.instrument = 'Acoustic Grand Piano'
        except Exception:
            pass # Keep instrument as None

        # Get Piece Name (from credit)
        try:
            credit_words = self.root.find('.//credit/credit-words')
            if credit_words is not None:
                self.name = credit_words.text
        except Exception:
             pass # Keep name as None

        # Process notes/chords/rests measure by measure, part by part
        for i, part in enumerate(self.root.findall('part')):
            for j, measure in enumerate(part.findall('measure')):
                measure_accidentals = {}
                self.set_key_sig_from_measure(measure)

                for k, note_info in enumerate(measure.findall('note')):
                    duration = note_info.find('type').text if note_info.find('type') is not None else None
                    is_chord_member = note_info.find('chord') is not None
                    is_rest = note_info.find('rest') is not None

                    note = None # Reset note for each element

                    if is_rest:
                        note = 'R' # Represent rest as 'R'
                    elif note_info.find('pitch') is not None:
                        step_elem = note_info.find('pitch/step')
                        octave_elem = note_info.find('pitch/octave')
                        alter_elem = note_info.find('pitch/alter') # For accidentals directly on note

                        step = step_elem.text if step_elem is not None else ''
                        octave = octave_elem.text if octave_elem is not None else ''

                        accidental_info_elem = note_info.find('accidental') # Check <accidental> tag
                        accidental_text = accidental_info_elem.text if accidental_info_elem is not None else None

                        note_for_accidental = step + octave
                        accidental = ''

                        if alter_elem is not None: # Direct alteration overrides <accidental> and key sig
                            alter = int(alter_elem.text)
                            if alter == 1: accidental = '#'
                            elif alter == -1: accidental = 'b'
                            elif alter == 0: accidental = 'n' # Natural explicitly marked
                        elif accidental_text == 'sharp': accidental = '#'
                        elif accidental_text == 'flat': accidental = 'b'
                        elif accidental_text == 'natural': accidental = 'n'
                        elif note_for_accidental in measure_accidentals: # Use existing accidental in measure
                             accidental = measure_accidentals[note_for_accidental]
                        else: # Use key signature default
                            accidental = self.key_sig_dict.get(step, '') # Get from calculated key sig dict

                        # Store current accidental for this measure if explicitly marked
                        if accidental_text is not None:
                            measure_accidentals[note_for_accidental] = accidental if accidental != 'n' else self.key_sig_dict.get(step, '')


                        # Handle naturals - they effectively revert to key sig for representation
                        if accidental == 'n':
                           accidental = self.key_sig_dict.get(step, '')

                        note = step + accidental + octave

                    # --- Chord / Note processing logic ---
                    current_sound_obj_data = None
                    if note is not None:
                        current_sound_obj_data = (note, duration) # Store note/rest and its duration

                        if is_chord_member: # Part of a chord
                           if in_chord and isinstance(sound_object_to_insert[0], tuple):
                               # Add note to existing chord tuple
                               current_notes = list(sound_object_to_insert[0])
                               current_notes.append(note)
                               sound_object_to_insert = (tuple(sorted(current_notes)), prev_duration) # Update chord, keep duration of first note
                           else:
                                # Should not happen if XML is well-formed (chord follows a note)
                                # If it does, treat this as the start of a new chord
                                chord = [prev_note, note]
                                sound_object_to_insert = (tuple(sorted(chord)), prev_duration)
                                in_chord = True
                        else: # Not part of a chord (single note or rest)
                            if in_chord: # Previous was a chord, so handle insertion of that chord first
                                self.handle_insertion(prev_sound_object, sound_object_to_insert)
                                prev_sound_object = sound_object_to_insert # The inserted chord becomes previous
                                in_chord = False # Reset chord flag

                            # Prepare the new single note/rest sound object
                            sound_object_to_insert = (note, duration)
                            prev_note = note # Update prev_note for potential next chord
                            prev_duration = duration # Update prev_duration

                            # Insert the transition from the previous sound object to this new one
                            self.handle_insertion(prev_sound_object, sound_object_to_insert)
                            prev_sound_object = sound_object_to_insert # This new object is now previous

                            # Track the very first sound object
                            if first_sound_object is None and prev_sound_object is not None and prev_sound_object[0] is not None:
                                first_sound_object = prev_sound_object


        # --- Handle the very last sound object ---
        is_last_iteration = True # Simplified: assume end after loops finish
        if is_last_iteration:
            last_obj_to_insert = None
            # Ensure the last object (chord or note) is inserted
            if in_chord:
                # Final object was a chord
                last_obj_to_insert = sound_object_to_insert
                self.handle_insertion(prev_sound_object, last_obj_to_insert)
            elif sound_object_to_insert is not None:
                 # Final object was a single note/rest
                 last_obj_to_insert = sound_object_to_insert
                 # Insertion likely already happened unless it was the *only* note
                 if prev_sound_object != sound_object_to_insert:
                      self.handle_insertion(prev_sound_object, last_obj_to_insert)
                 elif len(self.initial_transition_dict) == 0: # Handle case of only one note/rest in piece
                     self.handle_insertion(None, last_obj_to_insert)

            # Add transition from last actual sound object to a default rest
            if last_obj_to_insert is not None:
                quarter_rest_obj = ('R', 'quarter')
                self.handle_insertion(last_obj_to_insert, quarter_rest_obj)
                # Add transition from the default rest back to the first sound object
                if first_sound_object is not None:
                   self.handle_insertion(quarter_rest_obj, first_sound_object)
                else: # Handle edge case: piece only had one note, add loop back
                    self.handle_insertion(quarter_rest_obj, last_obj_to_insert)


    def set_key_sig_from_measure(self, measure_object):
        # Find key signature information if present in the measure attributes
        attributes = measure_object.find('attributes')
        if attributes is not None:
            key = attributes.find('key')
            if key is not None:
                fifths_elem = key.find('fifths')
                if fifths_elem is not None:
                    try:
                        key_sig_value = int(fifths_elem.text)
                        # Reset key_sig_dict based on fifths
                        self.key_sig_dict = {'C': '', 'D': '', 'E': '', 'F': '', 'G': '', 'A': '', 'B': ''} # Reset to default
                        if key_sig_value > 0: # Sharps
                            for i in range(key_sig_value):
                                note_to_sharp = self.order_of_sharps[i % len(self.order_of_sharps)]
                                self.key_sig_dict[note_to_sharp] = '#'
                        elif key_sig_value < 0: # Flats
                            order_of_flats = ['B', 'E', 'A', 'D', 'G', 'C', 'F']
                            for i in range(abs(key_sig_value)):
                                note_to_flat = order_of_flats[i % len(order_of_flats)]
                                self.key_sig_dict[note_to_flat] = 'b'
                        # else key_sig_value == 0 -> C Major / A minor (default)
                    except (ValueError, TypeError):
                        pass # Ignore if fifths is not a valid integer

    def handle_insertion(self, prev_sound_object, sound_object_to_insert):
         # Add state if new
        if sound_object_to_insert is not None and sound_object_to_insert not in self.states:
            self.states.append(sound_object_to_insert)

        # Increment initial count
        if sound_object_to_insert is not None:
             if sound_object_to_insert in self.initial_transition_dict:
                 self.initial_transition_dict[sound_object_to_insert] += 1
             else:
                 self.initial_transition_dict[sound_object_to_insert] = 1

        # Add transition count
        if prev_sound_object is not None and sound_object_to_insert is not None:
            self.insert(self.transition_probability_dict, prev_sound_object, sound_object_to_insert)

    def insert(self, dictionary, value1, value2):
        # Helper to insert/increment nested dictionary count
        if value1 not in dictionary:
            dictionary[value1] = {}
        if value2 not in dictionary[value1]:
            dictionary[value1][value2] = 1
        else:
            dictionary[value1][value2] += 1

    def build_matrices(self):
        # Build initial probability vector
        if not self.initial_transition_dict: return # Handle empty case

        init_counts = np.array([self.initial_transition_dict.get(s, 0) for s in self.states], dtype=float)
        total_counts = init_counts.sum()
        if total_counts > 0:
            init_probs = init_counts / total_counts
            self.normalized_initial_probability_vector = np.cumsum(init_probs)
            # Ensure the last element is exactly 1 due to potential float inaccuracies
            if len(self.normalized_initial_probability_vector) > 0:
                 self.normalized_initial_probability_vector[-1] = 1.0
        else: # Handle case where no notes were parsed
            self.normalized_initial_probability_vector = np.array([])


        # Build transition probability matrix
        list_dimension = len(self.states)
        if list_dimension == 0: return # Handle empty case

        trans_matrix = np.zeros((list_dimension, list_dimension), dtype=float)

        state_to_index = {state: i for i, state in enumerate(self.states)} # Map states to indices

        for from_state, transitions in self.transition_probability_dict.items():
            if from_state in state_to_index:
                i = state_to_index[from_state]
                for to_state, count in transitions.items():
                    if to_state in state_to_index:
                         j = state_to_index[to_state]
                         trans_matrix[i][j] = float(count)

        # Normalize rows to sum to 1 (probabilities)
        row_sums = trans_matrix.sum(axis=1, keepdims=True)
        # Avoid division by zero for states with no outgoing transitions (shouldn't happen with loopback)
        row_sums[row_sums == 0] = 1

        normalized_matrix = trans_matrix / row_sums

        # Calculate cumulative sum for inverse transform sampling
        self.normalized_transition_probability_matrix = np.cumsum(normalized_matrix, axis=1)

        # Ensure last element of each row is exactly 1.0
        if list_dimension > 0:
            self.normalized_transition_probability_matrix[:, -1] = 1.0


    # Helper to convert rhythm string to float duration (relative to quarter note)
    def rhythm_to_float(self, duration):
        switcher = {
            "whole": 4.0, "half": 2.0, "quarter": 1.0, "eighth": 0.5,
            "16th": 0.25, "32nd": 0.125, "64th": 0.0625, "128th": 0.03125
        }
        # Handle dotted notes approximately if needed, or duration types like 'breve'
        # For simplicity, only basic types are handled here.
        return switcher.get(duration, 1.0) # Default to quarter note if unknown

    # Helper to print dictionaries (for debugging)
    def print_dict(self, dictionary):
         for key, value in dictionary.items():
             print(key, ":", value)

```

### A.2. generate.py

```python
import parse_MusicXML # Assumes parse_MusicXML.py is in the same directory or path
import random
import numpy as np
import midiutil # requires 'pip install MIDIUtil'
import sys
import re
# midi_numbers.py would contain the instrument_to_program dictionary/function
# Example content for midi_numbers.py:
# def instrument_to_program(instrument_name):
#    mapping = {"Acoustic Grand Piano": 0, "Flute": 73, ...}
#    return mapping.get(instrument_name, 0) # Default to piano
import midi_numbers # Assuming this helper exists

# Helper function from StackOverflow (or similar) to find index of first element >= target
def find_nearest_above(my_array, target):
    # Find indices where array value is greater than or equal to target
    indices = np.where(my_array >= target)[0]
    if len(indices) > 0:
        return indices[0] # Return the first such index
    else:
        # Target is greater than all elements, return index of last element (or handle as error)
        # This case should ideally not happen if cumsum ends in 1.0 and target is <= 1.0
        if len(my_array) > 0:
            return len(my_array) - 1
        else:
             return None # Cannot find if array is empty

def check_null_index(index, error_message):
    if index is None:
        print(error_message, file=sys.stderr)
        sys.exit(1)

# MIDI note number calculation helpers
def get_note_offset_midi_val(note_letter):
    # Returns MIDI offset from C within an octave
    switcher = {
        "C": 0, "C#": 1, "Db": 1, "D": 2, "D#": 3, "Eb": 3, "E": 4, "Fb": 4, # Fb=E
        "E#": 5, "F": 5, "F#": 6, "Gb": 6, "G": 7, "G#": 8, "Ab": 8, "B": 11, "Cb": 11, # Cb=B
        "A": 9, "A#": 10, "Bb": 10,
        # Account for double sharps/flats if necessary, e.g., "Cx": 2, "Fbb": 3
    }
    # Handle case where accidental might be 'n' or missing - strip it first
    clean_note = note_letter.replace('n', '')
    return switcher.get(clean_note, 0) # Default to 0 if unknown

def get_pitch(note_string):
    # Converts note string like "C#4" to MIDI pitch number
    # Returns None if it's a rest ('R')
    if note_string == 'R':
        return None

    match = re.match(r'([A-Ga-g][#b]?)(\d+)', note_string) # Basic regex for Note+Octave
    if match:
        note_letter = match.group(1)
        octave_str = match.group(2)
        try:
            octave = int(octave_str)
            # MIDI standard: C4 is note 60. Octave 0 starts at C0=12
            base_octave_val = 12 * (octave + 1) # MIDI octave calculation
            note_offset = get_note_offset_midi_val(note_letter)
            midi_pitch = base_octave_val + note_offset
            return midi_pitch
        except ValueError:
            return None # Invalid octave number
    else: # Handle notes without octave? Or raise error? For now, return None.
        return None


def generate(seq_len, parser):
    """Generates a sequence of sound objects using the parser's Markov model."""
    sequence = [None] * seq_len
    if parser.normalized_initial_probability_vector is None or len(parser.normalized_initial_probability_vector) == 0:
         print("Error: Initial probability vector not generated.", file=sys.stderr)
         return []
    if parser.normalized_transition_probability_matrix is None or parser.normalized_transition_probability_matrix.shape[0] == 0:
        print("Error: Transition matrix not generated.", file=sys.stderr)
        return []

    # --- Choose initial state ---
    # Option 1: Use probability vector
    note_prob = random.uniform(0, 1)
    current_index = find_nearest_above(parser.normalized_initial_probability_vector, note_prob)
    check_null_index(current_index, "ERROR getting note index in initial probability vector")

    # Option 2: Start with the first state from the original piece (seed)
    # current_index = 0 # Assuming state 0 is the first parsed state

    if current_index >= len(parser.states):
         print(f"Error: Initial index {current_index} out of bounds for states (len {len(parser.states)})", file=sys.stderr)
         return []
    sequence[0] = parser.states[current_index]


    # --- Generate subsequent states ---
    for i in range(1, seq_len):
        if current_index >= parser.normalized_transition_probability_matrix.shape[0]:
             print(f"Error: current_index {current_index} out of bounds for transition matrix rows", file=sys.stderr)
             break # Stop generation if index is invalid

        note_prob = random.uniform(0, 1)
        # Get the row corresponding to the current state's index
        transition_row = parser.normalized_transition_probability_matrix[current_index]

        # Find the next state's index based on the random draw
        next_index = find_nearest_above(transition_row, note_prob)
        check_null_index(next_index, f"ERROR getting note index in probability transition matrix row {current_index}")

        if next_index >= len(parser.states):
             print(f"Error: next_index {next_index} out of bounds for states (len {len(parser.states)})", file=sys.stderr)
             break # Stop generation

        sequence[i] = parser.states[next_index]
        current_index = next_index # Update current index for the next iteration

    return [s for s in sequence if s is not None] # Return only generated states


if __name__ == "__main__":
    # Define the input files (original MusicXML)
    input_files = [
        'Cantabile_flute_excerpt.musicxml',
        'Cantabile_piano_excerpt.musicxml'
        # Add more files here if needed
    ]

    parsers = []
    for infile in input_files:
        try:
            print(f"Parsing {infile}...")
            p = parse_MusicXML.Parser(infile)
            parsers.append(p)
            print(f"Parsing complete. Found {len(p.states)} unique states.")
        except FileNotFoundError:
            print(f"Error: Input file not found: {infile}", file=sys.stderr)
        except Exception as e:
             print(f"Error parsing {infile}: {e}", file=sys.stderr)

    # Generate music for each parsed file
    for parser in parsers:
        if not parser.states: # Skip if parsing failed or file was empty
            print(f"Skipping generation for {parser.filename} due to parsing issues or no states found.")
            continue

        print(f"\nGenerating music based on {parser.filename}...")
        # Generate a sequence of 100 sound objects (notes/chords/rests)
        generated_sequence = generate(100, parser)
        print(f"Generated sequence of length {len(generated_sequence)}.")

        if not generated_sequence:
            print("Generation failed or produced an empty sequence.")
            continue

        # --- Create MIDI file ---
        output_midi = midiutil.MIDIFile(1) # One track
        track = 0
        channel = 0
        time = 0.0 # Start at the beginning

        # Set tempo (use parsed tempo or default)
        tempo = parser.tempo if parser.tempo is not None else 80 # Default BPM if not found
        output_midi.addTempo(track, time, tempo)

        # Set instrument (use parsed instrument or default)
        program = midi_numbers.instrument_to_program(parser.instrument)
        output_midi.addProgramChange(track, channel, time, program)

        volume = 100 # Standard MIDI volume (0-127)

        # Add notes to the MIDI file
        for sound_obj in generated_sequence:
            if sound_obj is None: continue # Skip if None somehow got in

            sound_info, duration_str = sound_obj
            duration = parser.rhythm_to_float(duration_str) # Convert duration string to float

            if isinstance(sound_info, str): # It's a single note or rest
                pitch = get_pitch(sound_info)
                if pitch is not None: # It's a note, add it
                    output_midi.addNote(track, channel, pitch, time, duration, volume)
                # If pitch is None, it's a rest ('R'), so we just advance time below
            elif isinstance(sound_info, tuple): # It's a chord
                for note in sound_info:
                    pitch = get_pitch(note)
                    if pitch is not None:
                        # Add all notes of the chord starting at the same time
                        output_midi.addNote(track, channel, pitch, time, duration, volume)

            # Advance time cursor by the duration of the note/chord/rest
            time += duration

        # --- Write the MIDI file ---
        # Construct output filename based on input filename
        output_filename_base = parser.filename.replace('.musicxml', '')
        output_filename = f"{output_filename_base}_generated.mid"
        try:
            with open(output_filename, "wb") as output_file:
                output_midi.writeFile(output_file)
            print(f"Successfully wrote MIDI file: {output_filename}")
        except Exception as e:
            print(f"Error writing MIDI file {output_filename}: {e}", file=sys.stderr)

```
