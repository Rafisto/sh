### Recursive File Organizer

A simple shell script to sort and copy files into a new directory.<br/>
Files are organized by their extension.

### Description

The folder consists of two programs:
- `files.sh <dir>` - generate a bunch of files in `dir` directory with different extensions and subdirectories.
- `organize.sh <dir> <out>` - organize files in `dir` by copying all the files to `out` with regard to the file extensions. The program keeps `dir` untouched.

### Example

Let's first generate some files to process:

```bash
$ ./files.sh files && cd files
files $ find -type f
./audio_file1.mp3
...
...
./video_file3.mp4
files $ cd ..
$
```

There are now some files with different extensions in `/files` directory.
Let's create another folder and move all items there. For that let's use
`organize.sh`:

```bash
$ ./organize.sh files organized
```

The program will copy all the items in `/files` directory to `/organized` with 
all the items being now sorted by their extension. To prevent accident data removal `/files` is untouched.

Let's see what has changed:

```
./
  /files
+ /organized
```

As you can see all the items have been successfully copied to a new directory. On top of that, the program also considers duplicate files and gives them a new filename with an index:

```bash
$ find files
files
files/audio_file1.mp3
files/audio_file2.mp3
files/image_file1.jpg
files/image_file2.jpg
files/image_file3.jpg
files/image_file4.jpg
files/image_file5.jpg
files/recursive
files/recursive/text_file10.txt
files/recursive/text_file11.txt
files/recursive/text_file12.txt
files/recursive/text_file5.txt
files/recursive/text_file6.txt
files/recursive/text_file7.txt
files/recursive/text_file8.txt
files/recursive/text_file9.txt
files/text_file1.txt
files/text_file10.txt
files/text_file2.txt
files/text_file3.txt
files/text_file4.txt
files/text_file5.txt
files/text_file6.txt
files/text_file7.txt
files/text_file8.txt
files/text_file9.txt
files/video_file1.mp4
files/video_file2.mp4
files/video_file3.mp4
```

```
$ find organized
organized/
organized/jpg
organized/jpg/image_file1.jpg
organized/jpg/image_file2.jpg
organized/jpg/image_file3.jpg
organized/jpg/image_file4.jpg
organized/jpg/image_file5.jpg
organized/mp3
organized/mp3/audio_file1.mp3
organized/mp3/audio_file2.mp3
organized/mp4
organized/mp4/video_file1.mp4
organized/mp4/video_file2.mp4
organized/mp4/video_file3.mp4
organized/txt
organized/txt/text_file1.txt
organized/txt/text_file10.1.txt
organized/txt/text_file10.txt
organized/txt/text_file11.txt
organized/txt/text_file12.txt
organized/txt/text_file2.txt
organized/txt/text_file3.txt
organized/txt/text_file4.txt
organized/txt/text_file5.1.txt
organized/txt/text_file5.txt
organized/txt/text_file6.1.txt
organized/txt/text_file6.txt
organized/txt/text_file7.1.txt
organized/txt/text_file7.txt
organized/txt/text_file8.1.txt
organized/txt/text_file8.txt
organized/txt/text_file9.1.txt
organized/txt/text_file9.txt
```