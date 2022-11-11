library(tidyverse, profvis)


text <- "itwasthebestoftimesitwastheworstoftimesitwastheageofwisdomitwastheageoffoolishnessitwastheepochofbeliefitwastheepochofincredulityitwastheseasonoflifeitwastheseasonofdarknessitwasthespringofhopeitwasthewinterofdespairwehadeverythingbeforeuswehadnothingbeforeuswewereallgoingdirecttoheavenwewereallgoingdirecttheotherwayinshorttheperiodwassofarthelikepresentperiodthatsomeofitsnoisiestauthoritiesinsistedonitsbeingreceivedforgoodorforevilinthesuperlativedegreeofcomparisononly"

cipher <- as.integer(encode("thequickbrownfxjmpsvlazydg"))

easychallenge <- encipher(cipher, encode(text))

challenge <- "btjpxrmlxpcuvamlxicvjpibtwxvrcimlmtrpmtnmtnyvcjxcdxvmwmbtrjjpxamtngxrjbahuqctjpxqgmrjxvcijpxymggcijpxhbtwrqmgmaxmtnjpxhbtwrmyjpxqmvjcijpxpmtnjpmjyvcjxjpxtjpxhbtwracutjxtmtaxymrapmtwxnmtnpbrjpcuwpjrjvcufgxnpblrcjpmjjpxscbtjrcipbrgcbtryxvxgccrxnmtnpbrhtxxrrlcjxctxmwmbtrjmtcjpxvjpxhbtwavbxnmgcunjcfvbtwbtjpxmrjvcgcwxvrjpxapmgnxmtrmtnjpxrccjprmexvrmtnjpxhbtwrqmhxmtnrmbnjcjpxybrxlxtcifmfegctypcrcxdxvrpmggvxmnjpbryvbjbtwmtnrpcylxjpxbtjxvqvxjmjbctjpxvxcirpmggfxagcjpxnybjpram"




jones1 <- read_tsv("Jones2004_Single.txt", quote = "") %>%
  filter(str_detect(Char, "[:lower:]|[:space:]"))

nyt <- jones1 %>% 
  select(letter = Char, NYT) %>%
  mutate(letter = factor(letter, levels = letters, ordered = TRUE), frequency = NYT/sum(NYT))

jones2 <- read_tsv("Jones2004_Bigram.txt", quote="") %>%
    filter(str_detect(Pred, "[:lower:]|[:space:]")) %>%
    filter(str_detect(Succ, "[:lower:]|[:space:]"))

## If any count is zero, make it 1 to avoid "impossible" likelihoods.
nyt2 <- jones2 %>%
    select(first = Pred, second = Succ, NYT) %>%
    mutate(NYT = ifelse(NYT == 0, 1, NYT)) %>%
    mutate(first = factor(first, levels = letters, ordered = TRUE),
           second = factor(second, levels = letters, ordered = TRUE),
           frequency = NYT/sum(NYT))

bigram <- matrix(nyt2$frequency, nrow = 26, dimnames = list(letters, letters))

perm_inverse <- function(p) {
    p[p] <- seq_along(p)
    p
}

## Compose two permutations
`%after%` <- function(p1, p2) {
    p1[p2]
}

## Convert text to and from numbers
encode <- function(txt) {
    factor(stringr::str_split_fixed(txt, "", Inf)[1,],
           levels = letters, ordered = TRUE)
}

decode <- function(cs) {
    cat(as.character(cs), sep = "")
}

## Encipher and decipher text, expressed as a factor
encipher <- function(key, plaintext) {
    factor(letters[key[plaintext]], levels = letters, ordered = TRUE)
}

decipher <- function(key, ciphertext) {
    factor(letters[perm_inverse(key)[ciphertext]], levels = letters, ordered = TRUE)
}



## (Slowly) compute the log-likelihood (base 2) of a text under the bigram ensemble
## This function is not optimised for repeated use in MCMC
## cs: a vector of int (eg, produced by `encode`) of length at least 1
## bigram: a matrix of probabilities where bigram[x, y] means the probability of x and y.  
bigram_log_likelihood <- function(cs, bigram) {

    marginal <- log2(apply(bigram, MARGIN = 2, sum))
    normalisation <- apply(bigram, MARGIN = 1, sum)
    conditional <- log2(bigram / rep(normalisation, each = length(marginal)))
    
    Ncs <- length(cs)

    cdl_ll <- function(i, j) {
        conditional[i, j]
    }
    
    marginal[cs[1]] + sum(mapply(cdl_ll, cs[-1], cs[1:(Ncs - 1L)]))
}



## Problem setup

cipher <- c(20L, 8L, 5L, 17L, 21L, 9L, 3L, 11L, 2L, 18L, 15L, 23L, 14L, 
            6L, 24L, 10L, 13L, 16L, 19L, 4L, 22L, 12L, 1L, 26L, 25L, 7L)

## MCMC

## precompute log-likelihoods

marginal <- log2(apply(bigram, MARGIN = 2, sum))
normalisation <- apply(bigram, MARGIN = 1, sum)
conditional <- log2(bigram / rep(normalisation, each = length(marginal)))


mcmc <- function(ciphertext, steps, guess = 1:26) {
    N <- length(ciphertext)
    test_cipher <- guess
    plaintext <- decipher(test_cipher, ciphertext)
    current_ll <- marginal[plaintext[1]] + sum(conditional[26 * (as.integer(plaintext[1:(N-1L)]) - 1L) + as.integer(plaintext[-1])])
    
    
    for (step in 1:steps) {
        ## Debugging
        if(step %% 1024L == 0) {
            cat(step, ": ", letters[test_cipher], ": ", sep="")
        }
    
        ## Choose a proposal
        transposition <- sample.int(26, 2)
        proposal <- test_cipher
        proposal[transposition] <- proposal[transposition[c(2,1)]]
        
        ## Compute transition probability
        plaintext <- decipher(proposal, ciphertext)

        firsts <- as.integer(plaintext[1:(N-1)])
        seconds <- as.integer(plaintext[-1])
        
        next_ll <- marginal[plaintext[1]] + sum(conditional[26 * (firsts - 1) + seconds])
        
        if (step %% 1024L == 0) cat(current_ll, "\n")
        log_r <- next_ll - current_ll 

        if (log_r > 0) {
            test_cipher <- proposal
            current_ll <- next_ll
        } else if (runif(1L) < 2^log_r) {
            test_cipher <- proposal
            current_ll <- next_ll
        }
    }
    cat("Key: ", letters[test_cipher], "\n", sep="")
    cat(letters[plaintext], sep = "", fill = 50)
    test_cipher
}

maximise_ll <- function(ciphertext, guess = 1:26) {
    ## Initialise
    N <- length(ciphertext)
    cipher_guess <- guess
    plaintext <- decipher(cipher_guess, ciphertext)

    current_ll <- marginal[plaintext[1]] + sum(conditional[26 * (as.integer(plaintext[1:(N-1L)]) - 1L) + as.integer(plaintext[-1])])

    delta <- +Inf
   
    while (delta > 0) {
        previous_ll <- current_ll

        ## Make a list of all 26*25 transpositions
        x <- rep(1:26, each = 26)
        y <- rep(1:26, times = 26)

        ## Remove dups
        xx <- x[x < y]
        yy <- y[x < y]
        
        ## Make a list of possible ciphers
        guesses <- mapply( ## TODO: This should probably be outer()
            function(f, s) {
                guess <- cipher_guess
                guess[c(s, f)] <- guess[c(f, s)]
                guess
            },
            x, y, SIMPLIFY = FALSE)

        ## Compute log-likelihoods
        lls <- lapply(guesses,
                      function(guess) {
                          plaintext <- decipher(guess, ciphertext)
                          
                          firsts <- as.integer(plaintext[1:(N-1)])
                          seconds <- as.integer(plaintext[-1])
                          marginal[plaintext[1]] + sum(conditional[26 * (firsts - 1) + seconds])
                      })

        best <- which.max(lls)

#        print(paste0("Best: ", best))
        
        cipher_guess <- guesses[[best]]
        current_ll <- lls[[best]]
        delta <- current_ll - previous_ll

    }
    ## Debugging
    cat(letters[cipher_guess], ": ", current_ll, "\n", sep="")
    cat(letters[plaintext], sep = "", fill = 50)
    cipher_guess
}
