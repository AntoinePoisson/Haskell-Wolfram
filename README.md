# Haskell-Wolfram
## Purpose:
<img src="https://i1.wp.com/atlas.wolfram.com/01/01/30/01_01_103_30.gif" alt="wolframn" /><br/>
It's 2nd year project of Epitech.<br/>
The goal of this project is to implement Wolfram’s elementary cellular automaton (below) in Haskell.<br/>

## Usage:
- To build (Stack at least 2.1.3 is mandatory):
```
make
```
- Binaire parameter:
```
  –rule : the ruleset to use (ryule 30, rule 90 and rule 110)
  –start : the generation number at which to start the display. The default value is 0.
  –lines : the number of lines to display. When homited, the program never stops.
  –window : the number of cells to display on each line (line width). If even,
   the central cell is displayed in the next cell on the right. The default value is 80.
  –move : a translation to apply on the window. If negative, the window is translated to the left.
   If positive, it’s translated to the right.
```

## Example:

```
$ ./ wolfram -- rule 30 -- lines 20
                    *
                   ***
                  ** **
                 ** ****
                ** * *  *
               ** **** ***
              ** * * *    *
             ** **** *******
            ** * *** *      *
           ** **** ** * ***  *
          ** * * **** ** *    *
         ** **** ** * * ****   *
        ** * *** ** ** * *      *
       ** **** ** *** *** ** *** *
      ** * * *** * *** * *        *
     ** **** ** * * ***** *******  *
    ** * *** **** * *** *           *
   ** **** ** *** ** ** * ***        *
  ** * * *** * ** *** **** ** *       *
 ** **** ** * ****** * * *** ****      *
```
## Note:
Grade A<br/>
Result moulinette Epitech: 100%
