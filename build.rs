use std::env;

const FLAGS: &[&str] = &[
    "-I@ROOT@/include/wx-3.2",
    "-I@ROOT@/lib/wx/include/osx_cocoa-unicode-static-3.2",
    "-D__WXMAC__",
    "-D__WXOSX__",
    "-D__WXOSX_COCOA__",
    "-DwxDEBUG_LEVEL=0",
    "-L@ROOT@/lib",
    "-lwx_osx_cocoau-3.2-Darwin",
    "-lz",
    "-lwxregexu-3.2",
    "-liconv",
    "-lwxjpeg-3.2",
    "-lwxpng-3.2",
    "-lwxtiff-3.2",
    "-lexpat",
    "-lframework=CoreFoundation",
    "-lframework=Carbon",
    "-lframework=Cocoa",
    "-lframework=QuartzCore",
    "-lframework=WebKit",
];

fn main() {
    let pkg_path = env::var("CARGO_MANIFEST_DIR").unwrap();
    let flags = FLAGS
        .iter()
        .map(|&f| f.replace("@ROOT@", &pkg_path).replace('\n', " "))
        .collect::<Vec<_>>();

    println!("cargo:cflags={}", flags.join(" "));
}
