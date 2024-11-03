{
    stdenv,
    git,
    nodejs,
    pnpm
}: stdenv.mkDerivation (finalAttrs: {
    pname = "scripts";
    version = "0.0.1";
    nativeBuildInputs = [
        git
        nodejs
        pnpm.configHook
    ];
    buildPhase = ''
        runHook preBuild
        pnpm run build
        runHook postBuild
    '';
    installPhase = ''
        runHook preInstall
        
        cp -r dist $out

        runHook postInstall
    '';
    src = ./.;
    pnpmDeps = pnpm.fetchDeps {
        inherit (finalAttrs) pname src;

        hash = "sha256-bosCE9gBFCcM3Ww6sJmhps/cl4lovXKMieYpkqAMst8=";
    };
    mata = with lib; {
    description = "personal scripts for the various things";
    homepage = "https://sadan.zip";
    license = lib.licenses.cc0;
    };
})
