//
//  main.m
//  piglatin
//
//  Created by Peter Hosey on 2012-02-12.
//

#include <readline/readline.h>

int main (int argc, char **argv) {
	@autoreleasepool {
		//For simplicity in this sample code (particularly given the frivolity of its purpose), I'm totally ignoring all languages but English. The question of whether a given letter is or isn't a vowel is near undecidable; for example, ‘y’ is a vowel, not a consonant, in many words, even in English. (For our purpose, we consider it a consonant because, at least in English, it almost never *starts* a word as a vowel.)
		NSString *initialEnglishAlphabetStr = @"abcdefghijklmnopqrstuvwxyz";
		NSCParameterAssert([initialEnglishAlphabetStr length] == 26);
		NSString *uppercaseEnglishAlphabetStr = [initialEnglishAlphabetStr uppercaseString];
		NSCharacterSet *uppercaseEnglishAlphabet = [NSCharacterSet characterSetWithCharactersInString:uppercaseEnglishAlphabetStr];
		initialEnglishAlphabetStr = [initialEnglishAlphabetStr stringByAppendingString:uppercaseEnglishAlphabetStr];
		NSCharacterSet *initialEnglishAlphabet = [NSCharacterSet characterSetWithCharactersInString:initialEnglishAlphabetStr];

		NSString *vowelsInEnglishStr = @"aeiou";
		vowelsInEnglishStr = [vowelsInEnglishStr stringByAppendingString:[vowelsInEnglishStr uppercaseString]];
		NSMutableCharacterSet *consonantsInEnglish = [initialEnglishAlphabet mutableCopy];
		[consonantsInEnglish removeCharactersInString:vowelsInEnglishStr];

		char *lineUTF8;
		while ((lineUTF8 = readline(""))) {
			NSMutableString *line = [NSMutableString stringWithUTF8String:lineUTF8];
			free(lineUTF8);

			[line enumerateSubstringsInRange:(NSRange){ 0, [line length] }
				options:NSStringEnumerationByWords
				usingBlock:^(NSString *word, NSRange wordRange, NSRange enclosingRange, BOOL *stop) {

					NSUInteger firstVowelIndex = 0UL;
					while ((firstVowelIndex < [word length]) && [consonantsInEnglish characterIsMember:[word characterAtIndex:firstVowelIndex]])
						++firstVowelIndex;

					if (firstVowelIndex == 0) {
						//Word starts with a vowel.
						word = [word stringByAppendingString:@"way"];
					} else {
						//Word starts with a consonant.
						NSString *consonantsThatStartWord = [word substringToIndex:firstVowelIndex];
						bool startsWithUppercase = [uppercaseEnglishAlphabet characterIsMember:[consonantsThatStartWord characterAtIndex:0UL]];
						word = [[[word substringFromIndex:firstVowelIndex] stringByAppendingString:consonantsThatStartWord] stringByAppendingString:@"ay"];
						if (startsWithUppercase)
							word = [word capitalizedString];
					}

					[line replaceCharactersInRange:wordRange withString:word];

				}];

			printf("%s\n", [line UTF8String]);
		}
	}
	return EXIT_SUCCESS;
}

