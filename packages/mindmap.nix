{
  fetchFromGitHub,
  installShellFiles,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "mindmap";
  version = "unstable-2024-07-06";

  src = fetchFromGitHub {
    owner = "coppertube";
    repo = "mindmap";
    rev = "659b796949dd2efe5dac49b69bb4b42e1bc71f68";
    hash = "sha256-Ht6zx5kpTqG4OYzp8NxQ7zDGg+2iu5atN8vw2sLB8EU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-6zmZFfAbDfR8JtVzsTOR0YCP+kzlglnG+u/W1QL23q8=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd todo \
      --bash <($out/bin/todo completion bash) \
      --fish <($out/bin/todo completion fish) \
      --zsh <($out/bin/todo completion zsh)
  '';

  meta = {
    description = "Delightful task manager, planner, and scheduler";
    homepage = "https://github.com/coppertube/mindmap";
    mainProgram = "mindmap";
    maintainers = with lib.maintainers; [ getpsyched ];
  };
}
