{ config, lib, pkgs, ... }:

{
  # Criar diretório de projetos
  home.activation.createProjectsDir =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p ~/projects
    '';

  # Variáveis de ambiente
  home.sessionVariables = { PROJECTS_DIR = "~/projects"; };
}
