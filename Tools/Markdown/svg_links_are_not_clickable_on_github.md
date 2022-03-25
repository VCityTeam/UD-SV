## Objective
As stated in [this stackOverflow post](https://stackoverflow.com/questions/70545385/github-markdown-svg-file-links-not-working):
```
I'm creating markdown file on a Github repo and want to embed a SVG 
file in the markdown in which the links from the SVG file are clickable.
My SVG file is saved in the same folder in the repo.
```
The short answer is: forget it.

Below are some failed trials...

## Markdown direct : FAILS image present but links are not clickable

```markdown
![](/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg)
```

![](/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg)

## Using `html image` will fail: the links won't work. Period. 

Links won't work because the rendered html will present that as
an image as opposed to svg...
     
### With plain `html img`: FAILS image present but links are not clickable

```html
<img src="/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg" ....>
```

<img src="/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg"
     align=center
     alt="Components sorted by categories"
     width="600"
     border="0">
     
### `html img` with a trailing `sanitize=true`: FAILS image present but links are not clickable
As proposed by https://stackoverflow.com/questions/46381436/github-svg-not-rendering-at-all use sanitize=true

<img src="https://raw.githubusercontent.com/VCityTeam/UD-SV/master/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg?sanitize=true"
     align=center
     alt="Components sorted by categories"
     width="600"
     border="0">

## Using `html object` will fail: its sanitized
     
Some html tags are sanitized by github's markdown renderer: [refer here](https://github.com/github/markup/issues/245#issuecomment-682231577).
Hence the following will fail
     
### With object and raw.githubusercontent.com : FAILS with nothing displayed

```html
<object type="data:image/svg+xml" data="https://raw.githubusercontent.com/VCityTeam/UD-SV/master/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg"></object>
```

<object type="data:image/svg+xml" data="https://raw.githubusercontent.com/VCityTeam/UD-SV/master/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg"></object>

### With object and relative path : FAILS with nothing displayed
<object type="data:image/svg+xml" data="/SoftwareComponents/Diagrams/ComponentSortedByCategories.svg"></object>
