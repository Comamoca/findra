# Release Process

This document describes how to create a new release for findra.

## Automated Release Workflow

The project uses GitHub Actions to automatically build and publish AppImage binaries when a new version tag is pushed.

### Creating a Release

1. **Update version** (if needed):
   ```bash
   # Update version in gleam.toml
   vim gleam.toml
   ```

2. **Commit changes**:
   ```bash
   git add gleam.toml
   git commit -m "chore: bump version to x.y.z"
   ```

3. **Create and push a version tag**:
   ```bash
   # Create a tag (e.g., v1.0.0)
   git tag v1.0.0

   # Push the tag to trigger the release workflow
   git push origin v1.0.0
   ```

4. **Monitor the workflow**:
   - Go to [Actions tab](../../actions)
   - Watch the "Release" workflow progress
   - It will build AppImages for multiple platforms

5. **Release published**:
   - Once complete, check [Releases](../../releases)
   - The new release will include:
     - AppImage binaries for x86_64 and ARM64
     - Auto-generated release notes
     - Installation instructions

## Supported Platforms

The release workflow builds for:

- **x86_64-linux** (Linux 64-bit Intel/AMD)
- **aarch64-linux** (Linux 64-bit ARM)

## Workflow Files

- `.github/workflows/release.yml` - Full workflow with cross-compilation
- `.github/workflows/release-simple.yml.example` - Simplified x86_64-only version

## Troubleshooting

### ARM64 build fails

If the ARM64 cross-compilation fails, you can switch to the simpler x86_64-only workflow:

```bash
# Disable the full workflow
mv .github/workflows/release.yml .github/workflows/release.yml.disabled

# Enable the simple workflow
mv .github/workflows/release-simple.yml.example .github/workflows/release.yml

# Commit and push
git add .github/workflows/
git commit -m "ci: switch to simple release workflow"
git push
```

### Cachix authentication

The workflow uses Cachix for build caching. To set it up:

1. Create a Cachix cache at https://app.cachix.org/
2. Generate an auth token
3. Add it as a secret named `CACHIX_AUTH_TOKEN` in repository settings

If you don't have Cachix, you can remove those steps from the workflow.

### Manual build

To build AppImage locally:

```bash
# Build using Nix
nix bundle --bundler github:ralismark/nix-appimage .#default

# The AppImage will be created in the current directory
ls *.AppImage
```

## Testing

Before creating a release, ensure:

```bash
# Tests pass
gleam test

# Code is formatted
gleam format --check src test

# Build succeeds
gleam build

# Nix build works
nix build
```

## Version Scheme

Follow [Semantic Versioning](https://semver.org/):

- **Major** (x.0.0): Breaking changes
- **Minor** (0.x.0): New features, backwards compatible
- **Patch** (0.0.x): Bug fixes, backwards compatible
