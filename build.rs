use std::env;
use std::fs;
use std::path::Path;

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

fn save_flags(flags: &str) {
    let out_dir = env::var_os("OUT_DIR").unwrap();
    let dest_path = Path::new(&out_dir).join("flags.rs");
    fs::write(&dest_path, format!("static FLAGS: &str = r\"{}\";", flags)).unwrap();
    println!("cargo:rerun-if-changed=build.rs");
}

fn main() {
    let pkg_path = env::var("CARGO_MANIFEST_DIR").unwrap();
    let flags = FLAGS
        .iter()
        .map(|&f| f.replace("@ROOT@", &pkg_path).replace('\n', " "))
        .collect::<Vec<_>>();

    save_flags(&flags.join(" "));
    println!("cargo:cflags={}", flags.join(" "));
}
