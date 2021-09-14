use std::env;

const FLAGS: &[&str] = &[
    "-I@ROOT@/include/wx-3.1",
    "-I@ROOT@/lib/wx/include/osx_cocoa-unicode-static-3.1",
    "-D__WXMAC__",
    "-D__WXOSX__",
    "-D__WXOSX_COCOA__",
    "-DwxDEBUG_LEVEL=0",
    "-L@ROOT@/lib",
    "-lwx_osx_cocoau-3.1-Darwin",
    "-lz",
    "-lwxregexu-3.1",
    "-liconv",
    "-lwxjpeg-3.1",
    "-lwxpng-3.1",
    "-lwxtiff-3.1",
    "-lwxscintilla-3.1",
    "-lexpat",
    "-lframework=Security",
    "-lframework=CoreFoundation",
    "-lframework=Carbon",
    "-lframework=Cocoa",
    "-lframework=IOKit",
    "-lframework=QuartzCore",
    "-lframework=AudioToolbox",
    "-lframework=WebKit",
    "-lframework=AVFoundation",
    "-lframework=CoreMedia",
    "-lframework=OpenGL",
    "-lframework=AVKit",
];

fn main() {
    let pkg_path = env::var("CARGO_MANIFEST_DIR").unwrap();
    let flags = FLAGS
        .iter()
        .map(|&f| f.replace("@ROOT@", &pkg_path).replace('\n', " "))
        .collect::<Vec<_>>();

    println!("cargo:cflags={}", flags.join(" "));
}
