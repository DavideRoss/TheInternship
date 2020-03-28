using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

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
    public Animator PlayerAnimator;

    private float _coffeeAmt = 1;
    private Rigidbody _rb;
    private float _lastArrow = 0;

    private bool _isStunned;
    private Transform _stunTarget;

    public GameObject Baloon;

    public int Requests = 0;
    public int Completed = 0;

    public Text RequestText;
    public Text CompletedText;

    void Start()
    {
        _rb = GetComponent<Rigidbody>();

        Baloon.SetActive(false);
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

        Vector3 input = Vector3.zero;

        if (!_isStunned)
        {
            input = new Vector3(
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
        }
        else
        {
            _targetRotation = Quaternion.LookRotation(_stunTarget.position);
            PlayerBody.transform.eulerAngles = Vector3.up * Mathf.MoveTowardsAngle(
                PlayerBody.transform.eulerAngles.y,
                _targetRotation.eulerAngles.y,
                RotationSpeed * Time.deltaTime
            );
        }

        // ================================================================================================================================
        // Translation
        // ================================================================================================================================

        if (!_isStunned)
        {
            Vector3 motion = input * WalkSpeed * Time.deltaTime;
            Vector3 newPos = transform.position += new Vector3(
                motion.x * speedDeg,
                0,
                motion.z * speedDeg
            );

            _rb.MovePosition(newPos);

            //print(input.magnitude);
            PlayerAnimator.SetFloat("Blend", input.magnitude * speedDeg);
            PlayerAnimator.SetFloat("Coffee", _coffeeAmt);
        }

        // ================================================================================================================================
        // Coffee degradation
        // ================================================================================================================================

        // TODO: if player is not moving consume less coffee
        float coffeeMinus = .0003f + input.magnitude * .0002f;
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

        CompletedText.text = Completed.ToString();
        RequestText.text = Requests.ToString();
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

        PlayerAnimator.SetBool("IsHoldingObject", true);

        PointerTarget = CEO;
    }

    private float Remap(float x, float x1, float x2, float y1, float y2) {
        float m = (y2 - y1) / (x2 - x1);
        float c = y1 - m * x1;
        return m * x + c;
    }

    public void StunPlayer(Transform target) {
        _isStunned = true;
        _stunTarget = target;
    }

    public void RemoveStun() {
        _isStunned = false;
        _stunTarget = null;
    }
    
    public bool IsStunned() {
        return _isStunned;
    }
}
