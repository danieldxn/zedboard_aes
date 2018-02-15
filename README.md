# AES Encryption/ Decryption on ZedBoard

Project is currently **in progress**, below is the complicated overview of the source control for this ZedBoard project...

#### Vivado File Structure
* `./ip_repo` (if exists, holds custom IP blocks)
* `./src` (files specified within build.tcl)
  *  Files specified within `build.tcl`
  *  Usually block designs (BD) constraints
  *  `/sources_1`
  *  `/constrs_1`
* `./build.tcl` (generated from Write Project to Tcl...)
* `./build.bat` (launcher for `build.tcl`)

#### SDK File Structure
* `./sdk`
  * Project files to import after setup 
  * Contains application and board support packages (BSP)

## Setup and Run
* Run `build.bat`
* Open `zedboard_aes.xpr`
* Generate Bitstream and Export Hardware
* Launch SDK
* Import project files from `./sdk`

## Updating Files

#### Changes to Hardware
* File -> Write Project to Tcl…
* Select Recreate Block Designs using Tcl
* Diff `build.tcl` with original
  * Copy files required into `./ip_repo` or `./src` and update paths
  * Set dynamic origin directory as so below: 

   *Edit*:
   ```
   # Set the reference directory for source  file relative paths (by default the value is  script directory path)
   set origin_dir [file dirname [info script]]
   ```
   ```
   # Create project
   create_project ${project_name} ${origin_dir} -part xc7z020clg484-1
   ```
   *Remove*:
   ```
   # Set the directory path for the original project from where this script was exported
   set orig_proj_dir "[file normalize "$origin_dir/zedboard_aes"]"
   ```

#### Changes to Software
* SDK project files should be all saved within `./sdk`
  * Any new projects within the SDK should be saved here 
  * `/main`
  * `/sd_bsp_0`

## Tags

#### Milestone 1

Based off the repository [Tiny AES in C](https://github.com/kokke/tiny-AES-c), the ECB and CBC algorithms were sourced. From there, the code was further stripped into the essentials needed for this project and a bare-metal application was created to run these algorithms. Verbose print statements were injected between stages/ between processing blocks. Instead of using hardcoded test strings, SD card support was implemented. The cipher key remained hardcoded however for convenience. For the application, a console-based design was made with the following menu choices:
* Input '1' to Format SD card
* Input '2' to Create TEST.BIN file
* Input '3' to Specify current file
* Input '4' to Enter CBC mode submenu
* Input '5' to Enter ECB mode submenu
* Input '6' to Byte compare two files
* Toggle 'SW0' high for verbose output
