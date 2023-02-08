# Lab 0: Functional Programming / The Actor Model

##### Due: March 3rd, 2023

## Week 1 - Welcome..

### Minimal Task

- [x] Follow an installation guide to install the language / development environment of your choice.
- [x] Write a script that would print the message “Hello PTR” on the screen.
Execute it.

### Main Task 

- [x] Initialize a VCS repository for your project. Push your project to a remote repo.

### Bonus Task

- [x] Write a comprehensive readme for your repository.
- [x] Create a unit test for your project. Execute it.

## Week 2 - ..to the rice fields 

### Minimal Task

- [x] Write a function that determines whether an input integer is prime.
```
isPrime(13) -> True
```
- [x] Write a function to calculate the area of a cylinder, given its height and
radius.
```
cylinderArea(3, 4) -> 175.9292
```
- [x] Write a function to reverse a list.
```
reverse([1, 2, 4, 8, 4]) -> [4, 8, 4, 2, 1]
```
- [x] Write a function to calculate the sum of unique elements in a list.
```
uniqueSum([1, 2, 4, 8, 4, 2]) -> 15
```
- [x] Write a function that extracts a given number of randomly selected elements
from a list.
```
extractRandomN([1, 2, 4, 8, 4], 3) -> [8, 4, 4]
```
- [x] Write a function that returns the first $n$ elements of the Fibonacci sequence.
```
firstFibonacciElements(8) -> [0, 1, 1, 2, 3, 5, 8, 13]
```
- [x] Write a function that, given a dictionary, would translate a sentence. Words
not found in the dictionary need not be translated.
```
dictionary = {
 "mama": "mother",
 "papa": "father"
 }
 original_string = "mama is with papa"
 translator(dictionary, original_string) -> "mother is with father"
```
- [x] Write a function that receives as input three digits and arranges them in an order that would create the smallest possible number. Numbers cannot start with a 0.
```
smallestNumber(4, 5, 3) -> 345
2 smallestNumber(0, 3, 4) -> 304
```
- [x] Write a function that would rotate a list $n$ places to the left.
```
rotateLeft([1, 2, 4, 8, 4], 3) -> [8, 4, 1, 2, 4]
```
- [x] Write a function that lists all tuples $a, b, c$ such that $a^2+b^2=c^2$ and $a,b\leq 20$.
```
listRightAngleTriangles() -> [(3, 4, 5), (...), ..]
```

### Main Task 

- [x] Write a function that eliminates consecutive duplicates in a list.
```
removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4]) -> [1, 2, 4, 8, 4]
```
- [x] Write a function that, given an array of strings, will return the words that can be typed using only one row of the letters on an English keyboard layout.
```
lineWords (["Hello","Alaska","Dad","Peace"]) -> ["Alaska","Dad"]
```
- [x] Create a pair of functions to encode and decode strings using the Caesar cipher.
```
 encode("lorem", 3) -> "oruhp"
 decode("oruhp", 3) -> "lorem"
```
- [x] Write a function that, given a string of digits from 2 to 9, would return all possible letter combinations that the number could represent (think phones with buttons).
```
lettersCombinations("23") -> ["ad","ae","af","bd","be","bf","cd","ce","cf"]
```
- [x] Write a function that, given an array of strings, would group the anagrams together.
```
groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]) -> {
 "abt": ["bat"],
 "ant": ["nat", "tan"],
 "aet": ["ate", "eat", "tea"]
 }
```

### Bonus Task

- [x] Write a function to find the longest common prefix string amongst a list of strings.
```
commonPrefix(["flower", "flow", "flight"]) -> "fl"
 commonPrefix(["alpha", "beta", "gamma"]) -> ""
```
- [x] Write a function to convert arabic numbers to roman numerals.
```
toRoman("13") -> "XIII"
```
- [x] Write a function to calculate the prime factorization of an integer.
```
factorize(13) -> [13]
factorize(42) -> [2, 3, 7]
```