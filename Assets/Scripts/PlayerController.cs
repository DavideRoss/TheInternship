using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float RotationSpeed = 8;
    public float WalkSpeed = 8;
    public GameObject PlayerBody;

    public GameObject Pointer;
    public Transform PlayerHand;
    public Transform CEO;

    private Quaternion _targetRotation;

    [HideInInspector]
    public GameObject HeldDossier;

    public FillBar CoffeeBar;

    [HideInInspector]
    public Transform PointerTarget;

    public Animator BlockAnimator;

    private float _coffeeAmt = 1;
    private Rigidbody _rb;
    private float _lastArrow = 0;

    void Start()
    {
        _rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        // ================================================================================================================================
        // Coffee malus
        // ================================================================================================================================

        float speedDeg = 1;
        float slowThreshold = .5f;
        if (_coffeeAmt < slowThreshold) speedDeg = Mathf.Max(_coffeeAmt * (1 / slowThreshold), .25f);

        // ================================================================================================================================
        // Rotation
        // ================================================================================================================================

        Vector3 input = new Vector3(
            Input.GetAxisRaw("Horizontal"),
            0,
            Input.GetAxisRaw("Vertical")
        );

        if (input != Vector3.zero)
        {
            _targetRotation = Quaternion.LookRotation(input);
            PlayerBody.transform.eulerAngles = Vector3.up * Mathf.MoveTowardsAngle(
                PlayerBody.transform.eulerAngles.y,
                _targetRotation.eulerAngles.y,
                RotationSpeed * Time.deltaTime
            );
        }

        // ================================================================================================================================
        // Translation
        // ================================================================================================================================

        Vector3 motion = input.normalized * WalkSpeed * .01f;
        Vector3 newPos = transform.position += new Vector3(
            motion.x * speedDeg,
            0,
            motion.z * speedDeg
        );

        _rb.MovePosition(newPos);

        // ================================================================================================================================
        // Coffee degrtadation
        // ================================================================================================================================

        // TODO: if player is not moving consume less coffee
        float coffeeMinus = .0004f + input.magnitude * .0003f;
        RefillCoffee(-coffeeMinus);

        // ================================================================================================================================
        // Pointer
        // ================================================================================================================================

        if (Pointer.activeInHierarchy) UpdatePointer();

        // ================================================================================================================================
        // Block animation
        // ================================================================================================================================

        float arrow = Mathf.Min(Input.GetAxisRaw("ArrowLeftRight"), 0);

        if (_lastArrow == 0 && arrow == -1)
        {
            BlockAnimator.SetTrigger("Display");
        }

        if (_lastArrow == -1 && arrow == 0)
        {
            BlockAnimator.SetTrigger("Hide");
        }

        _lastArrow = arrow;
    }

    public void RefillCoffee(float amt) {
        _coffeeAmt = Mathf.Clamp01(_coffeeAmt + amt);
        CoffeeBar.CurrentValue = _coffeeAmt;
    }

    public void TogglePointer() {
        Pointer.SetActive(!Pointer.activeInHierarchy);
    }

    private void UpdatePointer() {
        if (!PointerTarget) return;

        Vector3 pos = new Vector3(
            PointerTarget.position.x,
            Pointer.transform.position.y,
            PointerTarget.position.z
        );

        Pointer.transform.rotation = Quaternion.LookRotation((pos - transform.position).normalized);
    }

    public void Grab(GameObject dossier) {
        dossier.transform.parent = PlayerHand;
        dossier.transform.localPosition = Vector3.zero;
        dossier.transform.localRotation = Quaternion.identity;
        HeldDossier = dossier;

        PointerTarget = CEO;
    }

    private float Remap(float x, float x1, float x2, float y1, float y2) {
        float m = (y2 - y1) / (x2 - x1);
        float c = y1 - m * x1;
        return m * x + c;
    }
}
