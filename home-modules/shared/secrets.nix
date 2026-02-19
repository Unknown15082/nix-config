{ username, ... }:
{
    age.identityPaths = [
        "/home/${username}/.ssh/id_ed25519"
    ];
}
