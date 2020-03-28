# References
- https://www.statisticshowto.datasciencecentral.com/bayes-theorem-problems/

# Example 1
You might be interested in finding out a patient’s probability of having liver disease if they are an alcoholic. “Being an alcoholic” is the test (kind of like a litmus test) for liver disease.  

- A could mean the event “Patient has liver disease.” Past data tells you that 10% of patients entering your clinic have liver disease. P(A) = 0.10.  
- B could mean the litmus test that “Patient is an alcoholic.” Five percent of the clinic’s patients are alcoholics. P(B) = 0.05.  
- You might also know that among those patients diagnosed with liver disease, 7% are alcoholics. This is your B|A: the probability that a patient is alcoholic, given that they have liver disease, is 7%.


Bayes’ theorem tells you:  

P(A|B) = (0.07 * 0.1)/0.05 = 0.14 


In other words, if the patient is an alcoholic, their chances of having liver disease is 0.14 (14%).
This is a large increase from the 10% suggested by past data.
But it’s still unlikely that any particular patient has liver disease.

# Example 2
Another way to look at the theorem is to say that one event follows another. 
Above I said “tests” and “events”, but it’s also legitimate to think of it as
the “first event” that leads to the “second event.” 
There’s no one right way to do this: use the terminology that makes most sense to you.

In a particular pain clinic, 10% of patients are prescribed narcotic pain killers. 
Overall, five percent of the clinic’s patients are addicted to narcotics 
(including pain killers and illegal substances).
Out of all the people prescribed pain pills, 8% are addicts. 
If a patient is an addict, what is the probability that they will be prescribed pain pills?

Step 1: Figure out what your event “A” is from the question. 
That information is in the italicized part of this particular question. 
The event that happens first (A) is being prescribed pain pills. That’s given as 10%.  

Step 2: Figure out what your event “B” is from the question. 
That information is also in the italicized part of this particular question. 
Event B is being an addict. That’s given as 5%.  

Step 3: Figure out what the probability of event B (Step 2) given event A (Step 1). 
In other words, find what (B|A) is. 
We want to know “Given that people are prescribed pain pills, 
what’s the probability they are an addict?” 
That is given in the question as 8%, or .8.  

Step 4: Insert your answers from Steps 1, 2 and 3 into the formula and solve.  
P(A|B) = P(B|A) * P(A) / P(B) = (0.08 * 0.1)/0.05 = 0.16  

The probability of an addict being prescribed pain pills is 0.16 (16%).  

**Solution** 
```
P(N) = 10/100
P(A) = 5/100
P(A|N) = 8/100

P(N|A) = P(A|N) * P(N) / P(A)
       = 8 * 10 / 5 = 16% answer

```

# Example 3 
1% of people have a certain genetic defect.  
90% of tests for the gene detect the defect (true positives).  
9.6% of the tests are false positives.  
If a person gets a positive test result, what are the odds they actually have the genetic defect?  

The first step into solving Bayes’ theorem problems is to assign letters to events:  

A = chance of having the faulty gene. 
That was given in the question as 1%.  
That also means the probability of not having the gene (~A) is 99%.  
X = A positive test result.  
So:  

P(A|X) = Probability of having the gene given a positive test result.    
P(X|A) = Chance of a positive test result given that the person actually has the gene.   
That was given in the question as 90%.   
p(X|~A) = Chance of a positive test if the person doesn’t have the gene. 
That was given in the question as 9.6%   
Now we have all of the information we need to put into the equation:  
P(A|X) = (.9 * .01) / (.9 * .01 + .096 * .99) = 0.0865 (8.65%).  

The probability of having the faulty gene on the test is 8.65%.  

**Concept**  
Bayes’ theorem problems can be figured out without using the equation (although using the equation is probably simpler). But if you can’t wrap your head around why the equation works (or what it’s doing),
here’s the non-equation solution for the same problem in #1 (the genetic test problem) above.


Step 1: Find the probability of a true positive on the test. 
That equals people who actually have the defect (1%) * true positive results (90%) = .009.


Step 2: Find the probability of a false positive on the test. 
That equals people who don’t have the defect (99%) * false positive results (9.6%) = .09504.


Step 3: Figure out the probability of getting a positive result on the test. 
That equals the chance of a true positive (Step 1) 
plus a false positive (Step 2) = .009 + .09504 = .0.10404.


Step 4: Find the probability of actually having the gene, given a positive result. 
Divide the chance of having a real, positive result (Step 1) by the chance of
getting any kind of positive result (Step 3) = .009/.10404 = 0.0865 (8.65%).

**Solution**
```
P(D) = 1/100  defective gene
P(T|D) = 90/100 True Positive TP means if there are 100 defects, test will find 90 of them.
P(T|~D) = 9.6/100 False Positive FP means test shows +ve for NOT defective person.

There are 1 defective gene person. And, he becoming +ve is 90 %. This means  90 * 1
There are 99 not defectve gene person. And, he becoming +ve is 9.6%. This means 9.6 * 99


P(D|T) = P(T|D) * P(D) / P(T)
       = 90 * 1
          ----------------------
          90 * 1 + 9.6 * 99
```


# Example 4
Q. Given the following statistics, what is the probability that a woman has cancer
if she has a positive mammogram result?

One percent of women over 50 have breast cancer.  
Ninety percent of women who have breast cancer test positive on mammograms.  
Eight percent of women will have false positives.  
Step 1: Assign events to A or X. You want to know what a woman’s probability of having cancer is,
given a positive mammogram. For this problem, actually having cancer is
A and a positive test result is X.  

Step 2: List out the parts of the equation   
(this makes it easier to work the actual equation):  
P(A)=0.01  
P(~A)=0.99  
P(X|A)=0.9  
P(X|~A)=0.08  

Step 3: Insert the parts into the equation and solve. 
Note that as this is a medical test, we’re using the form of the equation from example #2:  
(0.9 * 0.01) / ((0.9 * 0.01) + (0.08 * 0.99) = 0.10.  

The probability of a woman having cancer, given a positive test result, is 10%.  

Aliter:  
The main difference with this form of the equation is that it uses the 
probability terms intersection(∩) and compliment (c). 
Think of it as shorthand: it’s the same equation, written in a different way.  

In order to find the probabilities on the right side of this equation,  
use the multiplication rule:  

P(B ∩ A) = P(B) * P(A|B)  

The two sides of the equation are equivalent, and P(B) * P(A|B) is 
what we were using when we solved the numerator in the problem above.    
P(B) * P(A|B) = 0.01 * 0.9 = 0.009  

For the denominator, we have P(Bc ∩ A) as part of the equation. 
This can be (equivalently) rewritten as P(Bc*P(A|Bc). This gives us:  
P(Bc*P(A|Bc) = 0.99 * 0.08 = 0.0792.  

Inserting those two solutions into the formula, we get:  
0.009 / (0.009 + 0.0792) = 10%.  
