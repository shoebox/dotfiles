final: prev: {
  devShell = mkShell {
    shellHook = ''
      echo "toto"
    '';
  };
}
