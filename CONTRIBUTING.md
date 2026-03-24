# Contributing to oss-scaffold

First of all, thank you for contributing! Your help makes this template better for everyone.

## Development Setup

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yevheniidehtiar/oss-scaffold
    cd oss-scaffold
    ```

2.  **Install dependencies**:
    We use [uv](https://github.com/astral-sh/uv) and [just](https://github.com/casey/just).
    ```bash
    just bootstrap
    ```

## Quality Control

Before submitting a pull request, please ensure all checks pass:

```bash
# Run linter and formatter
just lint

# Run scaffolding tests
just test
```

## Template Structure

-   `copier.yml`: The question specification for the template.
-   `template/`: The actual template files (with `.jinja` extensions where rendering is needed).
-   `tests/`: Scaffolding verification tests.

## Submitting Changes

1.  Create a new branch for your feature or bug fix.
2.  Write tests in `tests/` to verify your changes.
3.  Ensure `just qa` passes.
4.  Commit your changes using [conventional commits](https://www.conventionalcommits.org/).
5.  Open a Pull Request!
