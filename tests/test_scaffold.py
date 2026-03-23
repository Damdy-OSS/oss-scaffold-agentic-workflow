import subprocess
import shutil
import os
from pathlib import Path

def test_copier_scaffold():
    test_dir = Path("test-scaffold-output")
    if test_dir.exists():
        shutil.rmtree(test_dir)
    
    print("==> Running copier to scaffold test project...")
    # Run copier locally
    # -d allows passing data for questions
    # --defaults uses defaults for any unanswered
    # --force overwrites if exists
    result = subprocess.run([
        "copier", "copy", ".", str(test_dir),
        "--defaults",
        "--force",
        "--trust",
        "--skip-tasks",
        "-d", "project_name=Test Project",
        "-d", "project_description=A test project description",
        "-d", "author_name=Test Author",
        "-d", "author_email=test@example.com"
    ], capture_output=True, text=True)
    
    if result.returncode != 0:
        print(f"❌ Copier failed with exit code {result.returncode}")
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        assert False
    
    print("✓ Copier finished successfully")

    # Basic file presence checks
    assert (test_dir / "README.md").exists()
    assert (test_dir / "pyproject.toml").exists()
    assert (test_dir / "docs/agentic-workflow/index.md").exists()
    assert (test_dir / ".github/workflows/qa.yml").exists()
    assert (test_dir / ".pre-commit-config.yaml").exists()
    
    print("✓ Core files exist")

    # Check for TDD principle in roadmap planning doc
    roadmap_doc = (test_dir / "docs/agentic-workflow/roadmap-planning-agent.md").read_text()
    assert "Mandatory TDD" in roadmap_doc
    assert "Assembly First Principle" in roadmap_doc
    print("✓ TDD and Assembly First principles present in documentation")

    # Check for badges in README
    readme = (test_dir / "README.md").read_text()
    assert "actions/workflows/ci.yml" in readme
    assert "codecov.io" in readme
    assert "pepy.tech" in readme
    print("✓ Advanced badges present in README")

    # Cleanup
    shutil.rmtree(test_dir)
    print("✓ Cleanup complete")

if __name__ == "__main__":
    try:
        test_copier_scaffold()
        print("\n✨ All scaffolding tests passed!")
    except AssertionError as e:
        print(f"\n❌ Test failed: {e}")
        exit(1)
    except Exception as e:
        print(f"\n❌ An error occurred: {e}")
        exit(1)
