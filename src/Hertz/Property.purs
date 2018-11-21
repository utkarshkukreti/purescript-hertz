module Hertz.Property where

import Hertz.Internal (Property, property)

abbr' :: String -> Property
abbr' = property "abbr"

accept :: String -> Property
accept = property "accept"

acceptCharset :: String -> Property
acceptCharset = property "accept-charset"

accesskey :: String -> Property
accesskey = property "accesskey"

action :: String -> Property
action = property "action"

allow :: String -> Property
allow = property "allow"

allowfullscreen :: Boolean -> Property
allowfullscreen = property "allowfullscreen"

allowpaymentrequest :: Boolean -> Property
allowpaymentrequest = property "allowpaymentrequest"

alt :: String -> Property
alt = property "alt"

as :: String -> Property
as = property "as"

async :: Boolean -> Property
async = property "async"

autocapitalize :: String -> Property
autocapitalize = property "autocapitalize"

autocomplete :: Boolean -> Property
autocomplete = property "autocomplete"

autofocus :: Boolean -> Property
autofocus = property "autofocus"

autoplay :: Boolean -> Property
autoplay = property "autoplay"

charset :: String -> Property
charset = property "charset"

checked :: Boolean -> Property
checked = property "checked"

cite' :: String -> Property
cite' = property "cite"

color :: String -> Property
color = property "color"

cols :: Int -> Property
cols = property "cols"

colspan :: Int -> Property
colspan = property "colspan"

content :: String -> Property
content = property "content"

contenteditable :: Boolean -> Property
contenteditable = property "contenteditable"

controls :: Boolean -> Property
controls = property "controls"

coords :: String -> Property
coords = property "coords"

crossorigin :: String -> Property
crossorigin = property "crossorigin"

data'' :: String -> Property
data'' = property "data"

datetime :: String -> Property
datetime = property "datetime"

decoding :: String -> Property
decoding = property "decoding"

default :: Boolean -> Property
default = property "default"

defer :: Boolean -> Property
defer = property "defer"

dir :: String -> Property
dir = property "dir"

dirname :: String -> Property
dirname = property "dirname"

disabled :: Boolean -> Property
disabled = property "disabled"

download :: String -> Property
download = property "download"

draggable :: Boolean -> Property
draggable = property "draggable"

enctype :: String -> Property
enctype = property "enctype"

enterkeyhint :: String -> Property
enterkeyhint = property "enterkeyhint"

for :: String -> Property
for = property "for"

form' :: String -> Property
form' = property "form"

formaction :: String -> Property
formaction = property "formaction"

formenctype :: String -> Property
formenctype = property "formenctype"

formmethod :: String -> Property
formmethod = property "formmethod"

formnovalidate :: Boolean -> Property
formnovalidate = property "formnovalidate"

formtarget :: String -> Property
formtarget = property "formtarget"

headers :: String -> Property
headers = property "headers"

height :: String -> Property
height = property "height"

hidden :: Boolean -> Property
hidden = property "hidden"

high :: Number -> Property
high = property "high"

href :: String -> Property
href = property "href"

hreflang :: String -> Property
hreflang = property "hreflang"

httpEquiv :: String -> Property
httpEquiv = property "http-equiv"

id :: String -> Property
id = property "id"

inputmode :: String -> Property
inputmode = property "inputmode"

integrity :: String -> Property
integrity = property "integrity"

is :: String -> Property
is = property "is"

ismap :: Boolean -> Property
ismap = property "ismap"

itemid :: String -> Property
itemid = property "itemid"

itemprop :: String -> Property
itemprop = property "itemprop"

itemref :: String -> Property
itemref = property "itemref"

itemscope :: Boolean -> Property
itemscope = property "itemscope"

itemtype :: String -> Property
itemtype = property "itemtype"

kind :: String -> Property
kind = property "kind"

label' :: String -> Property
label' = property "label"

lang :: String -> Property
lang = property "lang"

list :: String -> Property
list = property "list"

loop :: Boolean -> Property
loop = property "loop"

low :: Number -> Property
low = property "low"

manifest :: String -> Property
manifest = property "manifest"

max :: Number -> Property
max = property "max"

maxlength :: String -> Property
maxlength = property "maxlength"

media :: String -> Property
media = property "media"

method :: String -> Property
method = property "method"

min :: Number -> Property
min = property "min"

minlength :: Int -> Property
minlength = property "minlength"

multiple :: Boolean -> Property
multiple = property "multiple"

muted :: Boolean -> Property
muted = property "muted"

name :: String -> Property
name = property "name"

nomodule :: Boolean -> Property
nomodule = property "nomodule"

nonce :: String -> Property
nonce = property "nonce"

novalidate :: Boolean -> Property
novalidate = property "novalidate"

open :: Boolean -> Property
open = property "open"

optimum :: Number -> Property
optimum = property "optimum"

pattern :: String -> Property
pattern = property "pattern"

ping :: String -> Property
ping = property "ping"

placeholder :: String -> Property
placeholder = property "placeholder"

playsinline :: Boolean -> Property
playsinline = property "playsinline"

poster :: String -> Property
poster = property "poster"

preload :: String -> Property
preload = property "preload"

readonly :: Boolean -> Property
readonly = property "readonly"

referrerpolicy :: String -> Property
referrerpolicy = property "referrerpolicy"

rel :: String -> Property
rel = property "rel"

required :: Boolean -> Property
required = property "required"

reversed :: Boolean -> Property
reversed = property "reversed"

rows :: Int -> Property
rows = property "rows"

rowspan :: Int -> Property
rowspan = property "rowspan"

sandbox :: String -> Property
sandbox = property "sandbox"

scope :: String -> Property
scope = property "scope"

selected :: Boolean -> Property
selected = property "selected"

shape :: String -> Property
shape = property "shape"

size :: Int -> Property
size = property "size"

sizes :: String -> Property
sizes = property "sizes"

slot' :: String -> Property
slot' = property "slot"

span' :: Int -> Property
span' = property "span"

spellcheck :: Boolean -> Property
spellcheck = property "spellcheck"

src :: String -> Property
src = property "src"

srcdoc :: String -> Property
srcdoc = property "srcdoc"

srclang :: String -> Property
srclang = property "srclang"

srcset :: String -> Property
srcset = property "srcset"

start :: Int -> Property
start = property "start"

step :: Number -> Property
step = property "step"

style' :: forall a. {| a} -> Property
style' = property "style"

tabindex :: Int -> Property
tabindex = property "tabindex"

target :: String -> Property
target = property "target"

title' :: String -> Property
title' = property "title"

translate :: Boolean -> Property
translate = property "translate"

type' :: String -> Property
type' = property "type"

typemustmatch :: Boolean -> Property
typemustmatch = property "typemustmatch"

usemap :: String -> Property
usemap = property "usemap"

value :: String -> Property
value = property "value"

width :: Int -> Property
width = property "width"

wrap :: String -> Property
wrap = property "wrap"
