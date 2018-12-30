# -*- coding: utf-8 -*-

"""
Converts most ascii chars into the upside-down equivalent in unicode.

Mostly a toy to figure out how to write add-ons for Sublime Text.
"""


import sublime, sublime_plugin


_UD_CHAR_CODES = {
    ' ': ' ', # single space
    '_': u'\u203E',
    '?': u'\u00BF',
    '!': u'\u00A1',
    '"': u'\u201E',
    "'": u'\u002C',
    '.': u'\u02D9',
    ',': u'\u0027',
    ';': u'\u061B',
    ':': ':',
    '(': ')',
    ')': '(',
    '[': ']',
    ']': '[',
    '{': '}',
    '}': '{',
    '<': '>',
    '>': '<',
    '\n': '\n',
    '\r': '\r',
    '\t': '\t',
    '0': u'0',
    '1': u'\u0196',
    '2': u'\u1105',
    '3': u'\u0190',
    '4': u'\u3123',
    '5': u'\u03DB',
    '6': u'9',
    '7': u'\u3125',
    '8': u'8',
    '9': u'6',
    'a': u'\u0250',
    'b': u'q',
    'c': u'\u0254',
    'd': u'p',
    'e': u'\u01dd',
    'f': u'\u025F',
    'g': u'\u0183',
    'h': u'\u0265',
    'i': u'\u0131',
    'j': u'\u027E',
    'k': u'\u029E',
    'l': u'l',
    'm': u'\u026F',
    'n': u'u',
    'o': u'o',
    'p': u'd',
    'q': u'b',
    'r': u'\u0279',
    's': u's',
    't': u'\u0287',
    'u': u'n',
    'v': u'\u028C',
    'w': u'\u028D',
    'x': u'x',
    'y': u'\u028E',
    'z': u'z',
    'A': u'\u2200',
    'B': u'\u0286', # or try u'\U00010412
    'C': u'\u0186',
    'D': u'\u15E1',
    'E': u'\u018E',
    'F': u'\u2132',
    'G': u'\u2141',
    'H': u'H',
    'I': u'I',
    'J': u'\u017F',
    'K': u'\u22CA',
    'L': u'\u02E5',
    'M': u'W',
    'N': u'\u004E',
    'O': u'O',
    'P': u'\u0500',
    'Q': u'\u038C',
    'R': u'\u1D1A',
    'S': u'S',
    'T': u'\u22A5',
    'U': u'\u2229',
    'V': u'\u039B',
    'W': u'M',
    'X': u'X',
    'Y': u'\u2144',
    'Z': u'Z',
}


def flip_text(s):
    chars = list(s)
    for i in range(len(chars)):
        chars[i] = _UD_CHAR_CODES[chars[i]]
    return ''.join(reversed(chars))


class FlipTextCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for region in self.view.sel():
            if not region.empty():
                s = flip_text(self.view.substr(region))
                self.view.replace(edit, region, s)
