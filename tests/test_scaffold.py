import subprocess
import shutil
from pathlib import Path


def test_copier_scaffold_default():
    test_dir = Path("test-scaffold-output-default")
    if test_dir.exists():
        shutil.rmtree(test_dir)

    print("\n==> Running copier to scaffold default project...")
    result = subprocess.run(
        [
            "copier",
            "copy",
            ".",
            str(test_dir),
            "--defaults",
            "--force",
            "--trust",
            "--skip-tasks",
            "-d",
            "project_name=Test Project",
            "-d",
            "project_description=A test project description",
            "-d",
            "author_name=Test Author",
            "-d",
            "author_email=test@example.com",
        ],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"❌ Copier failed with exit code {result.returncode}")
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        assert False

    # Basic file presence checks
    assert (test_dir / "README.md").exists()
    assert (test_dir / "pyproject.toml").exists()
    assert (test_dir / "docs/agentic-workflow/index.md").exists()
    assert (test_dir / ".github/workflows/qa.yml").exists()
    assert (test_dir / "CLAUDE.md").exists()

    # Check for TDD principle
    roadmap_doc = (
        test_dir / "docs/agentic-workflow/roadmap-planning-agent.md"
    ).read_text()
    assert "Mandatory TDD" in roadmap_doc

    shutil.rmtree(test_dir)


def test_copier_scaffold_no_ai():
    test_dir = Path("test-scaffold-output-no-ai")
    if test_dir.exists():
        shutil.rmtree(test_dir)

    print("\n==> Running copier to scaffold project with NO AI layer...")
    result = subprocess.run(
        [
            "copier",
            "copy",
            ".",
            str(test_dir),
            "--defaults",
            "--force",
            "--trust",
            "--skip-tasks",
            "-d",
            "project_name=No AI Project",
            "-d",
            "project_description=A test project with no AI layer",
            "-d",
            "author_name=Test Author",
            "-d",
            "author_email=test@example.com",
            "-d",
            "use_ai_layer=false",
        ],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"❌ Copier failed with exit code {result.returncode}")
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        assert False

    # AI files should NOT exist
    assert not (test_dir / "CLAUDE.md").exists()
    assert not (test_dir / "GEMINI.md").exists()
    assert not (test_dir / "JULES.md").exists()
    assert not (test_dir / ".mcp.json").exists()
    assert not (test_dir / ".claude").exists()
    assert not (test_dir / ".github/workflows/qa.yml").exists()

    # Core files should still exist
    assert (test_dir / "README.md").exists()
    assert (test_dir / "pyproject.toml").exists()

    shutil.rmtree(test_dir)


if __name__ == "__main__":
    # If run as a script, execute the tests
    test_copier_scaffold_default()
    test_copier_scaffold_no_ai()
    print("\n✨ All scaffolding tests passed!")
