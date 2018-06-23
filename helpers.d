module helpers;

import std.stdio : write, writeln, readln;
import std.algorithm.sorting : sort;
import std.range : array, enumerate;
import std.conv : parse, ConvException;
import std.string : toLower, strip;
import std.array : split;


// Validate that a string is a proper numeral between 1 and maxValue inclusive for the getChoice function.
int getValidatedInput(const string input, const int maxValue) {
    string temp = input.strip();

    try {
        const int result = temp.parse!int();
        if (result > maxValue || result < 1)
            return -1;
        else
            return result;
    }
    catch (ConvException)
        return -1; // Since the minimum choice index is 1, just return -1 if the input is invalid.
}

// Helper function to ask the user to pick one of the strings passed in as choices.
string getChoice(const string[] choices) {
    foreach (index, choice; choices.enumerate(1))
        writeln("[", index, "]: ", choice);

    write("\nSelection: ");
    int selection = getValidatedInput(readln(), choices.length);

    while (selection == -1) {
        write("Please make a valid selection: ");
        selection = getValidatedInput(readln(), choices.length);
    }

    string choice = choices[selection - 1];

    write("\nYou chose '" ~ choice ~ "'.\nIs this correct? (Y/n): ");

    if (readln().strip().toLower() == "n") {
        writeln();
        return getChoice(choices);
    }
    else
        return choice;
}
