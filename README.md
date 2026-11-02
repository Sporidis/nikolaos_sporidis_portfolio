# nikolaos_sporidis_portfolio

A new Jaspr project

## Running the project

Run your project using `jaspr serve`.

The development server will be available on `http://localhost:8080`.

## Building the project

Build your project using `jaspr build`.

The output will be located inside the `build/jaspr/` directory.

## FreshCart demo

The "Try the live demo" modal runs the real FreshCart Flutter app. It is made of
two parts:

- `web/demo/freshcart_demo.js`: the mount script. This is source and is committed.
- `web/demo/freshcart/`: FreshCart's Flutter web build. This is generated, gitignored,
  and has to be in place before `jaspr serve` or `jaspr build`.

To create or refresh the build, run this in the FreshCart repo:

```sh
cd freshcart_flutter
./tool/build_demo.sh            # builds lib/main_demo.dart, copies it to web/demo/freshcart/
./tool/build_demo.sh --serve    # or: build and preview it alone at http://localhost:8090/demo.html
```

The script expects this repo at `~/Documents/Portfolio/Website/nikolaos_sporidis_portfolio`.
Set `PORTFOLIO=/path/to/it` if it lives elsewhere.

Without the build, the site still works, but the demo modal's phone frames stay empty.
